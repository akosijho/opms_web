class SearchIndexService {
  List<String> setSearchIndex({required String string}) {
    final splitList = string.split(" ");
    List<String> indexList = [];
    List<String> tempList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y <= splitList[i].length; y++) {
        tempList.add(splitList[i].substring(0, y).toLowerCase());
      }
    }
    tempList.add(string.toLowerCase());
    indexList = tempList;

    return indexList;
  }
}
