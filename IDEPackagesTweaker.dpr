program IDEPackagesTweaker;

uses
  Vcl.Forms,
  uIDEPackagesTweakerMain in 'uIDEPackagesTweakerMain.pas' {frmPackageTwieaker};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPackageTwieaker, frmPackageTwieaker);
  Application.Run;
end.
