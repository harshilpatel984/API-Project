report 60100 CollectStudentData
{
    Caption = 'Collect Student Data';
    requestpage
    {
        layout
        {
            area(content)
            {
                group(NewStudentData)
                {
                    Caption = 'New Student Data';
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
    }
    trigger OnPreReport()
    var
        APIManagement: Codeunit APIManagement;
        Data: Label '{"id":"%1","firstname":"%2","lastname":"%3","email":"%4"}';
        ResponseText: Text;
        HTTPResponseData: HttpResponseMessage;
    begin
        APIManagement.CallAPI('POST', 'students', StrSubstNo(Data, Id, FirstName, LastName, Email), ResponseText, HTTPResponseData)
    end;

    var
        Id: Integer;
        FirstName: Text[50];
        LastName: Text[50];
        Email: Text[250];
}
