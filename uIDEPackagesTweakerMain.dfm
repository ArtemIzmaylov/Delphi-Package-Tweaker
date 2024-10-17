object frmPackageTwieaker: TfrmPackageTwieaker
  Left = 0
  Top = 0
  ClientHeight = 487
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 8
  Padding.Top = 8
  Padding.Right = 8
  Padding.Bottom = 8
  OnCreate = FormCreate
  TextHeight = 13
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 11
    Top = 11
    Width = 613
    Height = 434
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      BorderWidth = 5
      Caption = 'IDE: Common Packages'
      object lvDesignTimeCommon: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 589
        Height = 390
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Width = 250
          end
          item
            Width = 250
          end>
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet3: TTabSheet
      BorderWidth = 5
      Caption = 'IDE: Delphi Packages'
      ImageIndex = 2
      object lvDesignTimeDelphi: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 589
        Height = 390
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Width = 250
          end
          item
            Width = 250
          end>
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      BorderWidth = 5
      Caption = 'IDE: CBuilder Packages'
      ImageIndex = 3
      object lvDesignTimeCBuilder: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 589
        Height = 390
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Width = 250
          end
          item
            Width = 250
          end>
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet2: TTabSheet
      BorderWidth = 5
      Caption = 'Run Time Packages'
      ImageIndex = 1
      object lvRunTime: TListView
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 589
        Height = 390
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            Width = 250
          end
          item
            Width = 250
          end>
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 11
    Top = 451
    Width = 613
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 1
    object btnOK: TButton
      Left = 520
      Top = 0
      Width = 93
      Height = 25
      Align = alRight
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
end
