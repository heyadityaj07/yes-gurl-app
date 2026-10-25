import 'package:flutter_test/flutter_test.dart';
import 'package:yes_gurl/custom_code/actions/open_founder_calendly.dart';

void main() {
  group('founder selection mapping', () {
    test('maps the existing selections to the verified stable document IDs', () {
      expect(
        founderBookingConfigForSelection('annette')?.documentId,
        'annette',
      );
      expect(
        founderBookingConfigForSelection('francesca')?.documentId,
        'francesca',
      );
    });

    test('does not infer a founder from an unknown selection', () {
      expect(founderBookingConfigForSelection('fran'), isNull);
      expect(founderBookingConfigForSelection(''), isNull);
      expect(founderBookingConfigForSelection(null), isNull);
    });

    test('keeps the verified default URL with each founder ID', () {
      expect(
        founderBookingConfigForSelection('annette')?.defaultCalendlyUrl,
        'https://calendly.com/app-yesgurl/15-mins-with-annette',
      );
      expect(
        founderBookingConfigForSelection('francesca')?.defaultCalendlyUrl,
        'https://calendly.com/yesgurl/15-mins-with-francesca',
      );
    });
  });

  group('Calendly URL validation', () {
    final annette = founderBookingConfigForSelection('annette')!;
    final francesca = founderBookingConfigForSelection('francesca')!;

    test('accepts configured HTTPS Calendly links', () {
      expect(
        validatedFounderCalendlyUrl(annette, annette.defaultCalendlyUrl),
        annette.defaultCalendlyUrl,
      );
      expect(
        validatedFounderCalendlyUrl(francesca, francesca.defaultCalendlyUrl),
        francesca.defaultCalendlyUrl,
      );
    });

    test('accepts optional www, query, and trailing slash', () {
      expect(
        validatedFounderCalendlyUrl(
          annette,
          'https://www.calendly.com/app-yesgurl/15-mins-with-annette/?month=2026-11',
        ),
        'https://www.calendly.com/app-yesgurl/15-mins-with-annette/?month=2026-11',
      );
    });

    test('rejects non-HTTPS, non-Calendly, credentials, and custom ports', () {
      for (final value in [
        'http://calendly.com/app-yesgurl/15-mins-with-annette',
        'https://example.com/app-yesgurl/15-mins-with-annette',
        'https://user:pass@calendly.com/app-yesgurl/15-mins-with-annette',
        'https://calendly.com:8443/app-yesgurl/15-mins-with-annette',
        ' https://calendly.com/app-yesgurl/15-mins-with-annette',
        'not a url',
        '',
      ]) {
        expect(
          validatedFounderCalendlyUrl(annette, value),
          isNull,
          reason: value,
        );
      }
    });

    test('rejects the other founder event path', () {
      expect(
        validatedFounderCalendlyUrl(annette, francesca.defaultCalendlyUrl),
        isNull,
      );
      expect(
        validatedFounderCalendlyUrl(francesca, annette.defaultCalendlyUrl),
        isNull,
      );
    });

    test('rejects Calendly links that are not the configured event', () {
      for (final value in [
        'https://calendly.com/other-founder/15-mins',
        'https://calendly.com/app-yesgurl/15-mins-with-annette/extra',
        'https://calendly.com/app-yesgurl/15-mins-with-annette-evil',
      ]) {
        expect(
          validatedFounderCalendlyUrl(annette, value),
          isNull,
          reason: value,
        );
      }
    });
  });

  group('booking resolution', () {
    test('reads only the selected founder document and launches its URL',
        () async {
      final requestedIds = <String>[];
      final launchedUris = <Uri>[];

      final result = await resolveAndLaunchFounderBooking(
        selection: 'annette',
        readFounderLink: (documentId) async {
          requestedIds.add(documentId);
          return {
            'founder_name': 'Annette',
            'calendly_url':
                'https://calendly.com/app-yesgurl/15-mins-with-annette?month=2026-11',
          };
        },
        launchCalendly: (uri) async {
          launchedUris.add(uri);
          return true;
        },
      );

      expect(result.isSuccess, isTrue);
      expect(requestedIds, ['annette']);
      expect(launchedUris, [
        Uri.parse(
          'https://calendly.com/app-yesgurl/15-mins-with-annette?month=2026-11',
        ),
      ]);
    });

    test('resolves each founder without requesting the other document',
        () async {
      for (final selection in ['annette', 'francesca']) {
        final requestedIds = <String>[];
        final result = await resolveAndLaunchFounderBooking(
          selection: selection,
          readFounderLink: (documentId) async {
            requestedIds.add(documentId);
            return {
              'calendly_url': founderBookingConfigForSelection(selection)!
                  .defaultCalendlyUrl,
            };
          },
          launchCalendly: (_) async => true,
        );

        expect(result.isSuccess, isTrue);
        expect(requestedIds, [selection]);
      }
    });

    test('uses the verified default when the founder document is missing',
        () async {
      final result = await resolveAndLaunchFounderBooking(
        selection: 'francesca',
        readFounderLink: (_) async => null,
        launchCalendly: (_) async => true,
      );

      expect(result.isSuccess, isTrue);
      expect(
        result.url,
        'https://calendly.com/yesgurl/15-mins-with-francesca',
      );
    });

    test('fails rather than launching the other founder URL', () async {
      final launchedUris = <Uri>[];
      final result = await resolveAndLaunchFounderBooking(
        selection: 'annette',
        readFounderLink: (_) async => {
          'calendly_url':
              'https://calendly.com/yesgurl/15-mins-with-francesca',
        },
        launchCalendly: (uri) async {
          launchedUris.add(uri);
          return true;
        },
      );

      expect(result.failure, FounderBookingFailure.invalidUrl);
      expect(launchedUris, isEmpty);
    });

    test('fails when calendly_url is missing or empty', () async {
      for (final data in [
        <String, dynamic>{},
        <String, dynamic>{'founder_name': 'Annette'},
        <String, dynamic>{'calendly_url': null},
        <String, dynamic>{'calendly_url': ''},
        <String, dynamic>{'calendly_url': '   '},
      ]) {
        final result = await resolveAndLaunchFounderBooking(
          selection: 'annette',
          readFounderLink: (_) async => data,
          launchCalendly: (_) async => true,
        );

        expect(result.failure, FounderBookingFailure.missingUrl);
      }
    });

    test('fails when the configured URL is invalid', () async {
      final result = await resolveAndLaunchFounderBooking(
        selection: 'annette',
        readFounderLink: (_) async => {
          'calendly_url': 'http://calendly.com/app-yesgurl/15-mins-with-annette',
        },
        launchCalendly: (_) async => true,
      );

      expect(result.failure, FounderBookingFailure.invalidUrl);
    });

    test('fails without falling back when Firestore cannot be read', () async {
      final result = await resolveAndLaunchFounderBooking(
        selection: 'annette',
        readFounderLink: (_) async => throw StateError('permission-denied'),
        launchCalendly: (_) async => true,
      );

      expect(result.failure, FounderBookingFailure.lookupFailed);
      expect(result.url, isNull);
    });

    test('fails when the device cannot launch the URL', () async {
      final result = await resolveAndLaunchFounderBooking(
        selection: 'annette',
        readFounderLink: (_) async => null,
        launchCalendly: (_) async => false,
      );

      expect(result.failure, FounderBookingFailure.launchFailed);
    });

    test('fails when launching throws', () async {
      final result = await resolveAndLaunchFounderBooking(
        selection: 'annette',
        readFounderLink: (_) async => null,
        launchCalendly: (_) async => throw StateError('launcher unavailable'),
      );

      expect(result.failure, FounderBookingFailure.launchFailed);
    });

    test('rejects an unknown selection before reading Firestore', () async {
      var readCalled = false;
      final result = await resolveAndLaunchFounderBooking(
        selection: 'unknown',
        readFounderLink: (_) async {
          readCalled = true;
          return null;
        },
        launchCalendly: (_) async => true,
      );

      expect(result.failure, FounderBookingFailure.invalidSelection);
      expect(readCalled, isFalse);
    });
  });
}
