unit uIDEPackagesTweakerMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Registry;

{$IFDEF VER360}
const
  RootKey = 'Software\Embarcadero\BDS\23.0\';
  IDEName = 'RadStudio 12.0 Athens';
{$ENDIF}
{$IFDEF VER350}
const
  RootKey = 'Software\Embarcadero\BDS\22.0\';
  IDEName = 'RadStudio 11.0 Alexandria';
{$ENDIF}
{$IFDEF VER320}
const
  RootKey = 'Software\Embarcadero\BDS\19.0\';
  IDEName = 'RadStudio 10.2 Tokyo';
{$ENDIF}
{$IFDEF VER310}
const
  RootKey = 'Software\Embarcadero\BDS\18.0\';
  IDEName = 'RadStudio 10.1 Berlin';
{$ENDIF}
{$IFDEF VER300}
const
  RootKey = 'Software\Embarcadero\BDS\17.0\';
  IDEName = 'RadStudio 10 Seattle';
{$ENDIF}

type

  { TfrmPackageTwieaker }

  TfrmPackageTwieaker = class(TForm)
    btnOK: TButton;
    lvDesignTimeCommon: TListView;
    lvRunTime: TListView;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    lvDesignTimeDelphi: TListView;
    TabSheet4: TTabSheet;
    lvDesignTimeCBuilder: TListView;

    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    procedure PopulatePackages(AList: TListView; const AKey: string; AChecked: Boolean);
    procedure SaveChanges(AList: TListView; const AKey, AKeyForBackup: string);
  end;

var
  frmPackageTwieaker: TfrmPackageTwieaker;

implementation

{$R *.dfm}

const
  sBackupSubPath = '!PackagesBackup\';

{ TfrmPackageTwieaker }

procedure TfrmPackageTwieaker.btnOKClick(Sender: TObject);

  procedure DoSaveChanges(AList: TListView; const AKeyName: string);
  begin
    SaveChanges(AList, RootKey + AKeyName, RootKey + sBackupSubPath + AKeyName);
  end;

begin
  DoSaveChanges(lvDesignTimeCBuilder, 'Known IDE Packages\CBuilder');
  DoSaveChanges(lvDesignTimeCommon, 'Known IDE Packages');
  DoSaveChanges(lvDesignTimeDelphi, 'Known IDE Packages\Delphi');
  DoSaveChanges(lvRunTime, 'Known Packages');
  Close;
end;

procedure TfrmPackageTwieaker.FormCreate(Sender: TObject);

  procedure DoPopulatePackages(AList: TListView; const AKeyName: string);
  begin
    PopulatePackages(AList, RootKey + AKeyName, True);
    PopulatePackages(AList, RootKey + sBackupSubPath + AKeyName, False);
  end;

begin
  Caption := IDEName + ' Packages Tweaker';
  DoPopulatePackages(lvDesignTimeCommon, 'Known IDE Packages');
  DoPopulatePackages(lvDesignTimeDelphi, 'Known IDE Packages\Delphi');
  DoPopulatePackages(lvDesignTimeCBuilder, 'Known IDE Packages\CBuilder');
  DoPopulatePackages(lvRunTime, 'Known Packages');
end;

procedure TfrmPackageTwieaker.PopulatePackages(AList: TListView; const AKey: string; AChecked: Boolean);
var
  AItem: TListItem;
  ARegistry: TRegistry;
  AValues: TStringList;
  I: Integer;
begin
  AList.Items.BeginUpdate;
  try
    ARegistry := TRegistry.Create;
    try
      ARegistry.RootKey := HKEY_CURRENT_USER;
      if ARegistry.OpenKey(AKey, False) then
      try
        AValues := TStringList.Create;
        try
          ARegistry.GetValueNames(AValues);
          for I := 0 to AValues.Count - 1 do
          begin
            AItem := AList.Items.Add;
            AItem.Caption := AValues[I];
            AItem.SubItems.Add(ARegistry.ReadString(AValues[I]));
            AItem.Checked := AChecked;
          end;
        finally
          AValues.Free;
        end;
      finally
        ARegistry.CloseKey;
      end;
    finally
      ARegistry.Free;
    end;
  finally
    AList.Items.EndUpdate;
  end;
end;

procedure TfrmPackageTwieaker.SaveChanges(AList: TListView; const AKey, AKeyForBackup: string);
var
  ARegistry: TRegistry;
  I: Integer;
begin
  ARegistry := TRegistry.Create;
  try
    ARegistry.RootKey := HKEY_CURRENT_USER;

    // Update the backup section
    if ARegistry.OpenKey(AKeyForBackup, True) then
    try
      for I := 0 to AList.Items.Count - 1 do
      begin
        if AList.Items[I].Checked then
          ARegistry.DeleteValue(AList.Items[I].Caption)
        else
          ARegistry.WriteString(AList.Items[I].Caption, AList.Items[I].SubItems[0]);
      end;
    finally
      ARegistry.CloseKey;
    end;

    // Apply changes in main section
    if ARegistry.OpenKey(AKey, False) then
    try
      for I := 0 to AList.Items.Count - 1 do
      begin
        if AList.Items[I].Checked then
          ARegistry.WriteString(AList.Items[I].Caption, AList.Items[I].SubItems[0])
        else
          ARegistry.DeleteValue(AList.Items[I].Caption);
      end;
    finally
      ARegistry.CloseKey;
    end;
  finally
    ARegistry.Free;
  end;
end;

end.
