part of flutter_bootstrap;

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    Key key,
    @required Size media,
    @required this.projectItems,
  })  : _media = media,
        super(key: key);

  final Size _media;
  final List<Project> projectItems;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: _media.height / 1.9,
        width: _media.width / 3 + 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 20,
                  child: Text(
                    "Projects of the Month",
                    style: cardTitleTextStyle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(width: 2),
                          Text(
                            "Assigned",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Name",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Priority",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Budget",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: projectItems?.length ?? 0,
                        itemBuilder: (context, index) {
                          final _item = projectItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      child:
                                          Text(_item.assigned.substring(0, 2)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(_item.assigned),
                                  ],
                                ),
                                Text(
                                  _item.name,
                                  textAlign: TextAlign.justify,
                                ),
                                Container(
                                  child: Text(
                                    _item.priority.index == 0
                                        ? "Low"
                                        : _item.priority.index == 1
                                            ? "Medium"
                                            : "High",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  height: 30,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _item.color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Text("${_item.budget.toString()} K"),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum Priority {
  Low,
  Medium,
  High,
}

class Project {
  String assigned;
  String name;
  Priority priority;
  double budget;
  String position;
  String image;
  Color color;

  Project({
    this.assigned,
    this.name,
    this.priority,
    this.budget,
    this.image,
    this.position,
    this.color,
  });
}
