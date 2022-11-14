// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_is_empty

class PageMenuPermission {
  String? menuId;
  String? menuName;
  String? pageId;
  String? pageName;
  String? isGroup;
  String? prerentsMenu;
  String? systemID;
  String? icon;
  String? component;
  bool? delete;
  bool? excel;
  bool? save;
  bool? preview;
  bool? addnew;
  bool? isUse;
  List<MenuChild>? menuChilds;
  PageMenuPermission({
    this.menuId,
    this.menuName,
    this.pageId,
    this.pageName,
    this.isGroup,
    this.prerentsMenu,
    this.systemID,
    this.icon,
    this.component,
    this.delete,
    this.excel,
    this.save,
    this.preview,
    this.addnew,
    this.isUse,
    this.menuChilds,
  });

  factory PageMenuPermission.fromJson(Map<String, dynamic> json) {
    var _menuChilds = <MenuChild>[];
    var menuChildJson = json["menuChils"].cast<Map<String, dynamic>>() as List;
    if (menuChildJson.length > 0) {
      _menuChilds = menuChildJson
          .map<MenuChild>((jsonItem) => MenuChild.fromJson(jsonItem))
          .toList();
    }

    return PageMenuPermission(
        menuId: json["menuId"],
        menuName: json["menuName"],
        pageId: json["pageId"],
        pageName: json["pageName"],
        isGroup: json["isGroup"],
        prerentsMenu: json["prerentsMenu"],
        systemID: json["systemID"],
        icon: json["icon"],
        component: json["component"],
        delete: json["delete"],
        excel: json["excel"],
        save: json["save"],
        preview: json["preview"],
        addnew: json["addnew"],
        isUse: json["isUse"],
        menuChilds: _menuChilds);
  }
}

class MenuChild {
  String? menuId;
  String? menuName;
  String? pageId;
  String? pageName;
  String? isGroup;
  String? prerentsMenu;
  String? systemID;
  String? icon;
  String? component;
  bool? delete;
  bool? excel;
  bool? save;
  bool? preview;
  bool? addnew;
  bool? isUse;

  MenuChild({
    this.menuId,
    this.menuName,
    this.pageId,
    this.pageName,
    this.isGroup,
    this.prerentsMenu,
    this.systemID,
    this.icon,
    this.component,
    this.delete,
    this.excel,
    this.save,
    this.preview,
    this.addnew,
    this.isUse,
  });

  factory MenuChild.fromJson(Map<String, dynamic> json) {
    return MenuChild(
      menuId: json["menuId"],
      menuName: json["menuName"],
      pageId: json["pageId"],
      pageName: json["pageName"],
      isGroup: json["isGroup"],
      prerentsMenu: json["prerentsMenu"],
      systemID: json["systemID"],
      icon: json["icon"],
      component: json["component"],
      delete: json["delete"],
      excel: json["excel"],
      save: json["save"],
      preview: json["preview"],
      addnew: json["addnew"],
      isUse: json["isUse"],
    );
  }
}

class ListGroupMenuPermission {
  PageMenuPermission menu;

  ListGroupMenuPermission(this.menu);
}
