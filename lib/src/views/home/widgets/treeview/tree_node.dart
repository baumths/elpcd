part of 'tree_view.dart';

class TreeNode extends StatefulWidget {
  final PCDModel pcd;
  final int level;
  final List<TreeNode> children;

  final Function(PCDModel pcd) onTap;

  const TreeNode({
    @required this.pcd,
    @required this.level,
    @required this.onTap,
    this.children = const [],
  });

  @override
  _TreeNodeState createState() => _TreeNodeState();
}

class _TreeNodeState extends State<TreeNode>
    with SingleTickerProviderStateMixin {
  PCDModel pcd;
  bool _isExpanded = false;

  AnimationController _rotationController;
  final Tween<double> _turnsTween = Tween<double>(begin: 0.0, end: -0.5);

  initState() {
    this.pcd = widget.pcd;
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void toggleNode() {
    setState(() {
      _isExpanded
          ? _rotationController.reverse()
          : _rotationController.forward();
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildListTile(),
        Visibility(
          visible: pcd.hasChildren && _isExpanded,
          child: Column(
            children: widget.children,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ],
    );
  }

  Widget _buildListTile() {
    var leftOffset = widget.level == 0
        ? const EdgeInsets.symmetric(horizontal: 8)
        : EdgeInsets.only(left: widget.level * 24.0, right: 8);
    return Hero(
      tag: '${pcd.legacyId}',
      child: Material(
        child: ListTile(
          onTap: () => widget.onTap(this.pcd),
          title: Text(this.pcd.nome),
          leading: Tooltip(
            message: this.pcd.identifier,
            child: Chip(
              label: Text(this.pcd.codigo),
              backgroundColor: context.isDarkMode()
                  ? Colors.white.withOpacity(0.15)
                  : Colors.grey.withOpacity(0.5),
            ),
          ),
          contentPadding: leftOffset,
          trailing: _buildActions(context),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RotationTransition(
          turns: _turnsTween.animate(_rotationController),
          child: Offstage(
            offstage: !this.pcd.hasChildren,
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.expand_more),
              onPressed: this.toggleNode,
            ),
          ),
        ),
        IconButton(
          splashRadius: 20,
          tooltip: 'Nova Classe Subordinada',
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () {
            context.display(
              DescriptionView(
                DescriptionManager.newClass(parent: this.pcd),
              ),
            );
          },
        ),
      ],
    );
  }
}
