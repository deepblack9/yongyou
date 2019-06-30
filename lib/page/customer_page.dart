import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('ExpansionTile'),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) => new EntryItem(data[index]),
        itemCount: data.length,
      ),
    );
  }
}
// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.value, this.title, [this.children = const <Entry>[]]);
  final String value;
  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry('a', 'Chapter A',
    <Entry>[
      new Entry('a0', 'Section A0',
        <Entry>[
          new Entry('a0.1', 'Item A0.1'),
          new Entry('a0.2', 'Item A0.2'),
          new Entry('a0.3', 'Item A0.3'),
        ],
      ),
      new Entry('a1','Section A1'),
      new Entry('a2','Section A2'),
    ],
  ),
  new Entry('b','Chapter B',
    <Entry>[
      new Entry('b0','Section B0'),
      new Entry('b1','Section B1'),
    ],
  ),
  new Entry('c','Chapter C',
    <Entry>[
      new Entry('c0','Section C0'),
      new Entry('c1','Section C1'),
      new Entry('c2','Section C2',
        <Entry>[
          new Entry('c2.0','Item C2.0'),
          new Entry('c2.1','Item C2.1'),
          new Entry('c2.2','Item C2.2'),
          new Entry('c2.3','Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return new ListTile(title: new Text(root.title));
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}