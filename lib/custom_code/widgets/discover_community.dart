// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import '/auth/firebase_auth/auth_util.dart';
import '/components/community_card_widget.dart';
import '/link_up/no_community/no_community_widget.dart';

class DiscoverCommunity extends StatefulWidget {
  const DiscoverCommunity({
    super.key,
    this.width,
    this.height,
    required this.search,
  });

  final double? width;
  final double? height;
  final bool search;

  @override
  State<DiscoverCommunity> createState() => _DiscoverCommunityState();
}

class _DiscoverCommunityState extends State<DiscoverCommunity> {
  static const int _pageSize = 20;
  static const int _maxPages = 15;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<CommunityRecord> _communities = [];
  final Set<String> _joinedIds = {};

  DocumentSnapshot? _cursor;
  String _query = '';
  bool _loading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  int _pagesLoaded = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('[DiscoverCommunity] initState: search=${widget.search}');
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
    debugPrint(
        '[DiscoverCommunity] initState: listeners attached; starting load');
    _start();
  }

  @override
  void didUpdateWidget(covariant DiscoverCommunity oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.search && !widget.search) {
      _searchController.clear();
      _query = '';
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final next = _searchController.text.trim().toLowerCase();

    if (next == _query) {
      return;
    }
    setState(() {
      _query = next;
    });

    _fillUntilPage();
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _loading ||
        _loadingMore ||
        !_hasMore) {
      return;
    }
    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 240) {
      _loadNext();
    }
  }

  Future<void> _start() async {
    try {
      if (currentUserReference != null) {
        final memberships = await queryMembersRecordOnce(
          queryBuilder: (members) => members.where(
            'user_ref',
            isEqualTo: currentUserReference,
          ),
        );

        for (final member in memberships) {
          final communityId = member.reference.parent.parent?.id;
          if (communityId != null) {
            _joinedIds.add(communityId);
          }
        }
      }
      await _loadNext();
    } catch (error, stackTrace) {
      _hasMore = false;
    } finally {
      _loading = false;

      if (mounted) {
        setState(() {});
      } else {}
      _fillUntilPage();
    }
  }

  Future<void> _loadNext() async {
    if (_loadingMore) {
      return;
    }
    if (!_hasMore || _pagesLoaded >= _maxPages) {
      _hasMore = false;

      return;
    }
    _loadingMore = true;

    try {
      Query query = CommunityRecord.collection
          .where('community_type', whereIn: ['open', 'closed'])
          .orderBy('members', descending: true)
          .limit(_pageSize);
      if (_cursor != null) {
        query = query.startAfterDocument(_cursor!);
      }
      final snapshot = await query.get();

      _pagesLoaded += 1;
      if (snapshot.docs.isEmpty) {
        _hasMore = false;
      } else {
        _cursor = snapshot.docs.last;
        _hasMore =
            snapshot.docs.length == _pageSize && _pagesLoaded < _maxPages;

        for (final doc in snapshot.docs) {
          final record = CommunityRecord.fromSnapshot(doc);

          if (!_include(record)) {
            continue;
          }
          if (_communities
              .any((item) => item.reference.id == record.reference.id)) {
            continue;
          }
          _communities.add(record);
        }
      }
    } catch (error, stackTrace) {
      _hasMore = false;
    } finally {
      _loadingMore = false;
      if (mounted) {
        setState(() {});
      } else {}
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _onScroll();
        } else {}
      });
    }
  }

  void _fillUntilPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _loading || _loadingMore || !_hasMore) {
        debugPrint(
          '[DiscoverCommunity] _fillUntilPage stopped: mounted=$mounted, '
          'loading=$_loading, loadingMore=$_loadingMore, hasMore=$_hasMore',
        );
        return;
      }
      if (_visible.length >= _pageSize) {
        return;
      }
      await _loadNext();
      if (mounted && _visible.length < _pageSize && _hasMore) {
        _fillUntilPage();
      }
    });
  }

  bool _include(CommunityRecord community) {
    final type = community.communityType;
    if (type != CommunityType.open && type != CommunityType.closed) {
      return false;
    }
    if (_joinedIds.contains(community.reference.id)) {
      return false;
    }
    final me = currentUserReference;
    if (me != null && community.createdBy == me) {
      debugPrint(
        '[DiscoverCommunity] exclude id=${community.reference.id}: created by current user',
      );
      return false;
    }
    if (me != null && community.removedMembers.contains(me)) {
      debugPrint(
        '[DiscoverCommunity] exclude id=${community.reference.id}: current user was removed',
      );
      return false;
    }
    debugPrint('[DiscoverCommunity] include id=${community.reference.id}');
    return true;
  }

  bool _matchesQuery(CommunityRecord community) {
    if (!widget.search || _query.isEmpty) {
      return true;
    }
    final matches = community.name.toLowerCase().contains(_query);
    debugPrint(
      '[DiscoverCommunity] search match id=${community.reference.id}: $matches',
    );
    return matches;
  }

  List<CommunityRecord> get _visible =>
      _communities.where(_matchesQuery).toList();

  @override
  Widget build(BuildContext context) {
    debugPrint(
      '[DiscoverCommunity] build: searchEnabled=${widget.search}, '
      'queryLength=${_query.length}, loading=$_loading, loadingMore=$_loadingMore, '
      'hasMore=$_hasMore, loaded=${_communities.length}',
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final bounded = constraints.maxHeight.isFinite;
        final visible = bounded ? _visible : _visible.take(_pageSize).toList();

        final waiting =
            _loading || (visible.isEmpty && (_loadingMore || _hasMore));
        debugPrint(
          '[DiscoverCommunity] layout: bounded=$bounded, '
          'maxHeight=${constraints.maxHeight}, visible=${visible.length}, waiting=$waiting',
        );
        final list = waiting
            ? const Center(
                child: LinearProgressIndicator(
                  color: Color(0xFFFE99AB),
                ),
              )
            : visible.isEmpty
                ? const Center(child: NoCommunityWidget())
                : ListView.separated(
                    controller: bounded ? _scrollController : null,
                    primary: false,
                    shrinkWrap: !bounded,
                    physics: bounded
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 16, right: 16),
                    itemCount: visible.length + (_loadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                    itemBuilder: (context, index) {
                      if (index >= visible.length) {
                        debugPrint(
                            '[DiscoverCommunity] building pagination indicator');
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                            child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        );
                      }
                      final community = visible[index];
                      debugPrint(
                        '[DiscoverCommunity] building community card index=$index, '
                        'id=${community.reference.id}',
                      );
                      return CommunityCardWidget(
                        key: ValueKey(community.reference.id),
                        community: community,
                      );
                    },
                  );

        return SizedBox(
          width: widget.width ?? double.infinity,
          height: bounded ? constraints.maxHeight : null,
          child: Column(
            mainAxisSize: bounded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (widget.search) ...[
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12.0, left: 16, right: 16),
                  child: _searchField(context),
                ),
              ],
              if (bounded) Expanded(child: list) else list,
            ],
          ),
        );
      },
    );
  }

  Widget _searchField(BuildContext context) {
    debugPrint('[DiscoverCommunity] building search field');
    return TextFormField(
      controller: _searchController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'search',
        hintStyle: FlutterFlowTheme.of(context).labelMedium,
        filled: true,
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium,
      cursorColor: FlutterFlowTheme.of(context).primaryText,
    );
  }
}
