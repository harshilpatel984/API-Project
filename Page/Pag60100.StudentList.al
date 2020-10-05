page 60100 StudentList
{

    ApplicationArea = All;
    Caption = 'Students';
    PageType = List;
    SourceTable = Student;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Id)
                {
                    ApplicationArea = All;
                }
                field(FirstName; FirstName)
                {
                    ApplicationArea = All;
                }
                field(LastName; LastName)
                {
                    ApplicationArea = All;
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetData)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagement: Codeunit APIManagement;
                    ResponseText: Text;
                    HTTPResponseData: HttpResponseMessage;
                begin
                    APIManagement.CallAPI('GET', 'students', '', ResponseText, HTTPResponseData)
                end;
            }
            action(PostData)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Report.RunModal(60100);
                    CurrPage.Update(true);
                end;
            }
            action(DeleteData)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagement: Codeunit APIManagement;
                    ResponseText: Text;
                    HTTPResponseData: HttpResponseMessage;
                begin
                    APIManagement.CallAPI('DELETE', 'students', Format(Rec.Id), ResponseText, HTTPResponseData)
                end;
            }
        }
    }
}
