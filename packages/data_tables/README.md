# data_tables

* Full Screen Pagnitated Data Tables for Tablets/Desktops
* Mobile ListView with Action Buttons for Sorting and Selecting All
* Supports Dark Mode

## Getting Started

* You can optionally build the listview for mobile with a builder, by default it creates a ExpansionTile with the remaining columns as children
* The tablet breakpoint can also be set.

   `bool showMobileListView;` - When set to false it will always show a data table

   `int sortColumnIndex;` - Current Sorted Column

   `bool sortAscending;` - Sort Order

   `ValueChanged<bool> onSelectAll;` - Called for Selecting and Deselecting All

   `ValueChanged<int> onRowsPerPageChanged;` - Called when rows change on data table or last row reached on mobile.

   `int rowsPerPage;` - Default Rows per page

   `Widget header;` - Widget header for Desktop and Tablet Data Table

   `List<DataColumn> columns;` - List of Columns (Must match length of DataCells in DataSource)

   `DataTableSource dataSource;` - DataSource for the Data Table

   `IndexedWidgetBuilder mobileItemBuilder;` - Optional Item builder for the list view for Mobile

   `num tabletBreakpoint;` - Tablet breakpoint for the screen width

   `List<Widget> actions, selectedActions;` - Actions that show when items are selected or not

   `int mobileFetchNextRows;` - Default number of rows to fetch next

   `RefreshCallback onRefresh;` - If not null the list view will be wrapped in a RefreshIndicator

## Screenshots

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/1.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/2.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/3.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/4.PNG)

![](https://github.com/AppleEducate/plugins/blob/master/packages/data_tables/screenshots/5.PNG)
