   M S B A M L   `   `   `  ���� C  ?Unilever, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:UnileverUnilever  O Kmscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089I2clr-namespace:System.Collections;assembly=mscorlibSystem.Collections     Unilever.MainWindow   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     (localclr-namespace:Unilever     a ]DevExpress.Xpf.Core.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a;dx2http://schemas.devexpress.com/winfx/2008/xaml/core  c _DevExpress.Xpf.Ribbon.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxr4http://schemas.devexpress.com/winfx/2008/xaml/ribbon  <dxb2http://schemas.devexpress.com/winfx/2008/xaml/bars  Fdxbh;http://schemas.devexpress.com/winfx/2008/xaml/bars/internal  ?dxe5http://schemas.devexpress.com/winfx/2008/xaml/editors  d `DevExpress.Xpf.Docking.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a?dxd5http://schemas.devexpress.com/winfx/2008/xaml/docking  a	 ]DevExpress.Xpf.Grid.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49af
 bDevExpress.Xpf.Grid.v15.1.Core, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxg2http://schemas.devexpress.com/winfx/2008/xaml/grid 	 
 Fcollections2clr-namespace:System.Collections;assembly=mscorlib 	 
 c _DevExpress.Xpf.NavBar.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a?dxnb4http://schemas.devexpress.com/winfx/2008/xaml/navbar  c _DevExpress.Xpf.Charts.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a>dxc4http://schemas.devexpress.com/winfx/2008/xaml/charts  c _DevExpress.Xpf.Gauges.v15.1, Version=15.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a?dxga4http://schemas.devexpress.com/winfx/2008/xaml/gauges  -     � Title$  DXApplication��$	��700��$
��1100�� J� SnapsToDevicePixels .  � UseLayoutRounding .  � 	Resources ��%    .��]� .+�)  #DevExpress.Xpf.Ribbon.RibbonControl  -     Name$ ribbonControl1��   RibbonStyle$ 
Office2007=�$	��Top=�   ApplicationMenu +  %DevExpress.Xpf.Ribbon.ApplicationMenu     RightPaneWidth$	 280Q�   ShowRightPane . #  DevExpress.Xpf.Bars.PopupMenu	   Items	 +  %DevExpress.Xpf.Bars.BarButtonItemLink  %  DevExpress.Xpf.Bars.BarItemLink
   BarItemName$

 bNew��  $
 bOpen��  $
 bHelp��   	RightPane �� $��
Right Pane��   
BottomPane ��  �� Orientation$ 
Horizontal=�.+��� $��	OK button��   PageHeaderItems '  !DevExpress.Xpf.Bars.BarButtonItem  -     Name$
 bNew��!  DevExpress.Xpf.Bars.BarItem   Content)  #DevExpress.Xpf.Core.ObjectConverter$	 New    Glyph *	  $DevExpress.Xpf.Core.DXImageExtension	   	  Image1
  +DevExpress.Xpf.Core.Native.DXImageConverter$ new_16x16.png
    
LargeGlyph 	  $ New_32x32.png
   -   $ bOpen��$
 Open  	  $ open_16x16.png
  	  $ open_32x32.png
   -   $ bHelp��$
 Help  	  $ index_16x16.png
  	  $ index_32x32.png
    
Categories. 5  /DevExpress.Xpf.Ribbon.RibbonDefaultPageCategory  2  ,DevExpress.Xpf.Ribbon.RibbonPageCategoryBase   Pages. &   DevExpress.Xpf.Ribbon.RibbonPage  -    �Name$ Second��   Caption$ Products    Groups. +  %DevExpress.Xpf.Ribbon.RibbonPageGroup     Caption Z�    Glyph 	  $ EditDataSource_32x32.png
    
SmallGlyph 	  $ EditDataSource_16x16.png
    Items.   -   $ btnViewPros��$ View Products List  	  $ EditDataSource_32x32.png
  	  $ EditDataSource_32x32.png
   -   $ btnViewCats��$ View Categories List  	  $ FullStackedBar2_32x32.png
  	  $ FullStackedBar2_32x32.png
   -	   $ Third��$ Distributors .    Z� .   -
   $ btnViewDistributor��$ View Distributors List  	  $ EditDataSource_32x32.png
  	  $ EditDataSource_32x32.png
   -   $ btnAddDistribubor��$ Add Distributor  	  $ Add_32x32.png
  	  $ Add_32x32.png
   -   $ btnManageLiability��$ Manage liabilities  	  $ FormatAsTable_16x16.png
  	  $ FormatAsTable_16x16.png
   -   $ btnSaleRevenue��$ Manage sale revenues  	  $ FormatAsTable_16x16.png
  	  $ FormatAsTable_16x16.png
   -   $ btnManageInventory��$ Manage inventories  	  $ CalculateNow_16x16.png
  	  $ CalculateNow_16x16.png
    ToolbarItemLinks   $

 bNew��  $
 bOpen��.  (DevExpress.Xpf.Bars.BarItemLinkSeparator    $
 bCopy��  $
 bPaste��2  ,DevExpress.Xpf.Ribbon.RibbonStatusBarControl  =  7DevExpress.Xpf.Bars.Helpers.BlendHelperForBarsAndRibbon   IsDesignControl . $��Bottom=�   	LeftItems )  #DevExpress.Xpf.Bars.BarEditItemLink  $
 	eEditItem��*  $DevExpress.Xpf.Bars.BarCheckItemLink  $
 
eCheckItem��  $

 bCut��    
RightItems    $
 	eEditItem��  $
 
eCheckItem��+  %DevExpress.Xpf.Bars.BarStaticItemLink  $
 eStaticItem��  $

 bCut��.  (DevExpress.Xpf.Docking.DockLayoutManager  -   !  Name$! dockLayoutManager��"   
LayoutRoot." (  "DevExpress.Xpf.Docking.LayoutGroup  #   Items.#   $   Orientation$$ Vertical=�+  %DevExpress.Xpf.Docking.BaseLayoutItem%   	ItemWidth$% 3* �.# *  $DevExpress.Xpf.Docking.DocumentGroup  -   &  Name$& documentGroup��'   
ItemHeight$' 3* �(   ClosePageButtonShowMode$( InActiveTabPageHeader=�.# *  $DevExpress.Xpf.Docking.DocumentPanel  -   $& 
productTab��)   Caption$) Products��$' 3* �*   ShowCloseButton* . (  "DevExpress.Xpf.Docking.ContentItem+   Content.+ % 	 DevExpress.Xpf.Grid.GridControl  -   ,  Name$, gridProducts��) 
 #DevExpress.Xpf.Grid.DataControlBase-   AutoGenerateColumns$- AddNew=�.   
ShowBorder. .  /   View/ # 	 DevExpress.Xpf.Grid.TableView  -   $��tblProducts��0   AllowBandResizing0 . 1   AllowBestFit1 . & 
  DevExpress.Xpf.Grid.DataViewBase2   AllowColumnMoving2 . 3   AllowResizing3 .   -   $& categoriesTab��$) 
Categories��$' 2* �4   Closed4 . .+   -   $, gridCategories��$- AddNew=�. .  /   0 . 1 . 2 . 3 .   -   $& distributorsTab��$) Distributors��$' 3* �4 . .+   -   $, gridDistributors��$- AddNew=�. .  /   -   $��tblDistributors��0 . 1 . 2 . 3 .   -   $& liabilitiesTab��$) Liabilities��$' 3* �4 . .+   -   $, gridLiabities��$- AddNew=�. .  /   -   $��tblLiabilities��0 . 1 . 2 . 3 .   -   $& salerevenueTab��$) Sale revenues��$' 3* �4 . .+   -   $, gridSaleRevenues��$- AddNew=�. .  /   -   $��tblSaleRevenues��0 . 1 . 2 . 3 .   -   $& inventoriesTab��$) Inventories��$' 3* �4 . .+   -    $, gridInventories��$- AddNew=�. .  /   -!   $��tblInventories��0 . 1 . 2 . 3 .   $) 
DetailView��$
' 1.5* �* . $( InActiveTabPageHeader=�.#   $) Product details��.+ � $��0,0,0,0q�5 � RowDefinitions5 �� $��1* ��� $��1* ��� $��1* ��� $��1* ��� $��1* ��� $��1* �6 � ColumnDefinitions6 �� $
��0.3* ��� $
��0.9* ��� $��0.15* �.+��� $��0��$��0��$
��Name��$��16(��� $��1��$��0��$��Price��$��16(��� $��2��$��0��$��Category��$��16(��� $��3��$��0��$��
ImportDate��$��16(��� $��4��$��0��$��Remaining amount��$��16(��� $��5��$��0��$��Descript��$��16(�%  DevExpress.Xpf.Editors.TextEdit  -"   $��txtpName��$��0��$��1��  -#   $��	txtpPrice��$��1��$��1��)   #DevExpress.Xpf.Editors.ComboBoxEdit   -$   $��cbxpCategory��+!  %DevExpress.Xpf.Editors.LookUpEditBase7 !  AutoComplete7 . '"  !DevExpress.Xpf.Editors.ButtonEdit8 "  IsTextEditable$8 FalseX�$��2��$��1��%#  DevExpress.Xpf.Editors.DateEdit#  -%   $��depImportDate��9 #  	ShowToday9 . $��3��$��1��  -&   $��
txtpRemain��$��4��$��1��  -'   $��txtpDescript��$��5��$��1���� $ Vertical=�$��5��$��2��$��0�� : �� 
TargetType; �� Property< �� Value��%3   '��       �� ": ��.��� ; � ��$< 0,20,0,0q�.+��� -(   $��btnUpdatePros��$��0��$��2��$��0,0,0,0q�$��Update���� -)   $��
btnAddPros��$��2��$��2��$��0,0,0,0q�$	��Add���� -*   $��btnRemovePros��$��2��$��2��$��0,0,0,0q�$��Remove���� -+   $��btnClearText��$��4��$��2��$��0,0,0,0q�$��
Clear text��  -,   $& dpSaleRevenues��$) Sale revenue details��.+ � 5 �� $
��0.2* ��� 6 �� $
��180* ��� $
��429* ��� $
��122* ��� $	��61* �.+�  --   $, gridSaleRevenueDetails��$��0��$��2��$��2��$- AddNew=�. .  /   -.   $��tblSaleRevenueDetails��0 . 1 . =   ShowBandsPanel= . 2 . 3 .   -/   $, gridSaleRevenueReduce��$��0��$��2��$��2��$��2��$- AddNew=�. .  /   -0   $��tblSaleRevenueReduce��0 . 1 . 2 . 3 . ($  "DevExpress.Xpf.Docking.TabbedGroup$  $% * �.# (%  "DevExpress.Xpf.Docking.LayoutPanel%  -1   $& 	manageTab��$) Distributor��4 . .+ � 5 �� $��5* ��� $��1* �6 �� $
��0.3* ��� $��* �.+��� $��	0,100,0,0q�$��0��$��1�� ��%H   '        �� ":  .��� ; � ��$< 0,3,0,0q��� ; � ��$< 40��.+�  -2   $��txtdbId��%&  DevExpress.Xpf.Editors.BaseEdit> &  NullText$> Id��{�.    -3   $��	txtdbName��$
> Name��  -4   $��
txtdbEmail��$> Email��  -5   $��
txtdbPhone��$> Phone��)'  #DevExpress.Xpf.Editors.TextEditBase? '  	MaxLength$? 15��  -6   $��	txtdbAddr��$> Address���� $��	0,110,0,0q�$��0��$��0�� ��%H   '��       �� ": ��.��� ; � ��$< 0,3,0,0q��� ; � ��$< 40��.+��� $��ID���� $
��Name���� $��Email���� $��Phone���� $��Address���� -7   $��distFooterGrid��$��1��$��0��$��2��.��� 5 �� 6 �� �� �� .+��� -8   $��btndbAdd��$	��Add��$��0��$��2��$��35��$��70��$��Bottom=��� -9   $��btndbUpdate��$��Update��$��0��$��1��$��35��$��70��$��Bottom=��� -:   $��btndbRemove��$��Remove��$��0��$��0��$��35��$��70��$��Bottom=�%  -;   $& liabilityTab��$) 	Liability��.+ � 5 �� $��5* ��� $��1* �6 �� $
��0.7* ��� $��* �.+��� $��	0,110,0,0q�$��0��$��1�� ��%H   '        �� ":  .��� ; � ��$< 0,3,0,0q��� ; � ��$< 40��.+�  -<   $��txtdlid��{�.    -=   $��	txtdldbid��  ->   $��txtdldbname��  -?   $��txtdlorderid��  -@   $��txtdlresday��@ &  	EditValue$@ 0 �� $��	0,110,0,0q�$��0��$��0�� ��%H   '��       �� ": ��.��� ; � ��$< 0,7,0,0q��� ; � ��$< 40��.+��� $��D/L Id��A � ToolTip$A Defferred liability id���� $��
Distrib Id���� $��Distrib Name���� $��Order Id���� $��Rescheduling (day)���� -A   $��defliaFooterGrid��$��1��$��0��$��2��.��� 5 �� 6 �� �� �� .+��� -B   $��btndlUpdate��$��Update��$��0��$��2��$��35��$��70��$��Bottom=��� -C   $��btndlRemove��$��Remove��$��0��$��1��$��35��$��70��$��Bottom=�B   AutoHideGroupsB *(  $DevExpress.Xpf.Docking.AutoHideGroup(  .# %  $) 
Navigation��$	% 200 �C   Padding$C 1q�.+ ))  #DevExpress.Xpf.NavBar.NavBarControl)  -D   $��navBarControl��$��Stretch=�$��Stretch=�$��1q�D )  GroupsD '*  !DevExpress.Xpf.NavBar.NavBarGroup*  E *  Header$E Group1 F *  ImageSource$F Images/Icons/Group.png��G *  Items.G &+   DevExpress.Xpf.NavBar.NavBarItem+  H +  Content$H Item1 I +  ImageSource$I Images/Icons/Item.png��*  $E Group2 $F Images/Icons/Group.png��.G +  $H Item1 $I Images/Icons/Item.png��J )  ViewJ .,  (DevExpress.Xpf.NavBar.NavigationPaneView,  K ,  IsExpandButtonVisibleK .  %  $) Tools��