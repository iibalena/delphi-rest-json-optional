object MainDemo: TMainDemo
  Left = 0
  Top = 0
  Caption = 'Delphi REST JSON Optional Demo'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    600
    400)
  TextHeight = 13
  object btnGerarJson: TButton
    Left = 16
    Top = 16
    Width = 120
    Height = 25
    Caption = 'Gerar JSON'
    TabOrder = 0
    OnClick = btnGerarJsonClick
  end
  object btnCarregarJson: TButton
    Left = 152
    Top = 16
    Width = 120
    Height = 25
    Caption = 'Carregar JSON'
    TabOrder = 1
    OnClick = btnCarregarJsonClick
  end
  object MemoJSON: TMemo
    Left = 16
    Top = 56
    Width = 568
    Height = 160
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object MemoLog: TMemo
    Left = 16
    Top = 232
    Width = 568
    Height = 145
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
