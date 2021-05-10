unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Notification, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TForm7 = class(TForm)
    NotificationCenter1: TNotificationCenter;
    ButtonSetNumber: TButton;
    ButtonNotification: TButton;
    ButtonRepeatNotif: TButton;
    ButtonStopRepeat: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure ButtonSetNumberClick(Sender: TObject);
    procedure ButtonNotificationClick(Sender: TObject);
    procedure ButtonRepeatNotifClick(Sender: TObject);
    procedure ButtonStopRepeatClick(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}



procedure TForm7.ButtonNotificationClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := 'TEST';
    MyNotification.AlertBody := 'TEST for your mobile device is here!';
    MyNotification.FireDate := Now + EncodeTime(0, 0, strtoint(Edit1.text), 0); // Fired in 10 seconds
    MyNotification.EnableSound := True ;
    //MyNotification.Number := 18;
    NotificationCenter1.ScheduleNotification(MyNotification); // Send notification to the notification center
  finally
    MyNotification.DisposeOf;
  end;
end;




procedure TForm7.ButtonRepeatNotifClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Title := 'TEST';
    MyNotification.AlertBody := 'TEST Repeating notification each minute!';
    MyNotification.FireDate := Now + EncodeTime(0, 0, 0, 0);
    MyNotification.EnableSound := True ;
    MyNotification.RepeatInterval := TRepeatInterval.Minute;
    NotificationCenter1.ScheduleNotification(MyNotification); // Send notification to the notification center
  finally
    MyNotification.Free;
  end;
end;





procedure TForm7.ButtonSetNumberClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
      MyNotification.Number := 20 ;
      //MyNotification.AlertBody := 'TEST for your mobile device is here!';
      MyNotification.EnableSound := False ;
      NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;



procedure TForm7.ButtonStopRepeatClick(Sender: TObject);
begin
  NotificationCenter1.CancelNotification('TEST');
end;


procedure TForm7.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
  ShowMessage('The ' + ANotification.Name + ' notification clicked.' );
end;





procedure TForm7.Edit1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Edit1.Text = '' then Edit1.Text := '0' ;
end;

end.
