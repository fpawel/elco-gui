object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 608
  object FDConnectionElcheseDB: TFDConnection
    Params.Strings = (
      'Database=$(MYAPPDATA)\'#1040#1085#1072#1083#1080#1090#1087#1088#1080#1073#1086#1088'\elco\elco.sqlite'
      'LockingMode=Normal'
      'StringFormat=Unicode'
      'BusyTimeout=100'
      'JournalMode=Off'
      'SharedCache=False'
      'DriverID=SQLite')
    UpdateOptions.AssignedValues = [uvLockWait]
    UpdateOptions.LockWait = True
    Left = 80
    Top = 24
  end
end
