page 60101 StudentAPI
{

    APIGroup = 'apiproject';
    APIPublisher = 'hp';
    ODataKeyFields = Id;
    APIVersion = 'v1.0';
    Caption = 'Student API';
    DelayedInsert = true;
    EntityName = 'student';
    EntitySetName = 'students';
    PageType = API;
    SourceTable = Student;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Id)
                {
                    ApplicationArea = All;
                    Caption = 'Id';
                }
                field(firstname; FirstName)
                {
                    ApplicationArea = All;
                    Caption = 'FirstName';
                }
                field(lastname; LastName)
                {
                    ApplicationArea = All;
                    Caption = 'LastName';
                }
                field(email; Email)
                {
                    ApplicationArea = All;
                    Caption = 'Email';
                }
            }
        }
    }

}
