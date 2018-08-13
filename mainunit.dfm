object mainform: Tmainform
  Left = 276
  Top = 125
  Width = 881
  Height = 597
  Caption = 'Warzone savegame editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    873
    551)
  PixelsPerInch = 96
  TextHeight = 13
  object sb: TStatusBar
    Left = 0
    Top = 532
    Width = 873
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 30
    Width = 871
    Height = 501
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object CheckListBox1: TCheckListBox
      Left = 10
      Top = 10
      Width = 121
      Height = 97
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 10
    Top = 0
    Width = 126
    Height = 25
    Caption = 'Load component list'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 145
    Top = 0
    Width = 126
    Height = 25
    Caption = 'Save component list'
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 840
    object filemenu: TMenuItem
      Caption = 'File'
      object opens: TMenuItem
        Caption = 'Open savegame'
        ShortCut = 114
        OnClick = opensClick
      end
      object closes: TMenuItem
        Caption = 'Close savegame'
        Enabled = False
        ShortCut = 119
        OnClick = closesClick
      end
      object sep01: TMenuItem
        Caption = '-'
      end
      object csgd: TMenuItem
        Caption = 'Change savegames directory'
        ShortCut = 115
        OnClick = csgdClick
      end
      object sep02: TMenuItem
        Caption = '-'
      end
      object quit: TMenuItem
        Caption = 'Quit'
        ShortCut = 32883
        OnClick = quitClick
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      object Preferences1: TMenuItem
        Caption = 'Preferences'
        ShortCut = 118
      end
    end
    object helpmenu: TMenuItem
      Caption = 'Help'
      object about: TMenuItem
        Caption = 'About'
        ShortCut = 16496
      end
    end
  end
end
