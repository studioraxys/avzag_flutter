import 'dart:ui';

import 'package:avzag/widgets/span_icon.dart';
import 'package:flutter/material.dart';
import 'package:avzag/utils/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'hit_tile.dart';
import 'search_controller.dart';

class SearchResultsSliver extends StatelessWidget {
  const SearchResultsSliver(
    this.search,
    this.paging, {
    this.onTap,
    Key? key,
  }) : super(key: key);

  final SearchController search;
  final PagingController<int, String> paging;
  final ValueSetter<EntryHit>? onTap;

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
      pagingController: paging,
      builderDelegate: PagedChildBuilderDelegate<String>(
        itemBuilder: (context, term, _) {
          final hitGroups = search.getHits(term);
          final tags = search.getTags(term);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 14,
                      ),
                  children: [
                    const WidgetSpan(child: SizedBox(width: 20)),
                    TextSpan(
                      text: capitalize(term),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const WidgetSpan(
                      child: SpanIcon(
                        Icons.tag_outlined,
                        padding: EdgeInsets.only(left: 4, right: 2),
                      ),
                    ),
                    TextSpan(
                      text: prettyTags(
                        tags,
                        separator: ' ',
                        capitalized: false,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: hitGroups.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final hits = hitGroups[index];
                    return Column(
                      children: [
                        if (index > 0) const Divider(),
                        for (var i = 0; i < hits.length; i++)
                          HitTile(
                            hits[i],
                            showLanguage: i == 0,
                            onTap: onTap == null ? null : () => onTap!(hits[i]),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
        noItemsFoundIndicatorBuilder: buildEndCaption,
        noMoreItemsIndicatorBuilder: buildEndCaption,
      ),
    );
  }

  Widget buildEndCaption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpanIcon(Icons.check_outlined),
          Text(
            'End of results',
            style: Theme.of(context).textTheme.caption?.copyWith(
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
