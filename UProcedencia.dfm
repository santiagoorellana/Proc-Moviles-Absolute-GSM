object FProcedencia: TFProcedencia
  Left = 426
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Procedencia'
  ClientHeight = 146
  ClientWidth = 286
  Color = clInactiveCaptionText
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000BBBBBB0EEEEEEE0AAAAAAAA099999900BBB
    BBB0EEEEEEE0AAAAAAAA099999900BBBBBB0EEEEEEE0AAAAAAAA099999900BBB
    BBB0EEEEEEE0AAAAAAAA099999900BBBBBB0EEEEEEE0AAAAAAAA099999900BBB
    BBB0EEEEEEE0AAAAAAAA09999990000000000000000000000000000000000EEE
    EEE0CCCCCCC0999999990BBBBBB00EEEEEE0CCCCCCC0999999990BBBBBB00EEE
    EEE0CCCCCCC0999999990BBBBBB00EEEEEE0CCCCCCC0999999990BBBBBB00EEE
    EEE0CCCCCCC0999999990BBBBBB00EEEEEE0CCCCCCC0999999990BBBBBB00EEE
    EEE0CCCCCCC0999999990BBBBBB0000000000000000000000000000000000999
    9990BBBBBBB0EEEEEEEE0CCCCCC009999990BBBBBBB0EEEEEEEE0CCCCCC00999
    9990BBBBBBB0EEEEEEEE0CCCCCC009999990BBBBBBB0EEEEEEEE0CCCCCC00999
    9990BBBBBBB0EEEEEEEE0CCCCCC009999990BBBBBBB0EEEEEEEE0CCCCCC00999
    9990BBBBBBB0EEEEEEEE0CCCCCC0000000000000000000000000000000000AAA
    AAA0CCCCCCC0999999990AAAAAA00AAAAAA0CCCCCCC0999999990AAAAAA00AAA
    AAA0CCCCCCC0999999990AAAAAA00AAAAAA0CCCCCCC0999999990AAAAAA00AAA
    AAA0CCCCCCC0999999990AAAAAA00AAAAAA0CCCCCCC0999999990AAAAAA00AAA
    AAA0CCCCCCC0999999990AAAAAA0000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    286
    146)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 19
    Width = 251
    Height = 44
    Caption = 'Proc GSM'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 108
    Width = 245
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 70
    Width = 107
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'Producido por: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 127
    Width = 269
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = La habana, Cuba, 2013.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 197
    Top = 2
    Width = 78
    Height = 16
    Caption = 'Versi'#243'n 1.5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 88
    Width = 161
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'Santiago A. Orellana P'#233'rez'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ActionList1: TActionList
    Left = 214
    Top = 67
    object ActionSalir: TAction
      Caption = 'ActionSalir'
      ShortCut = 27
      OnExecute = ActionSalirExecute
    end
  end
end
