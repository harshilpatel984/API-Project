table 60100 Student
{
    Caption = 'Student';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = CustomerContent;
        }
        field(2; FirstName; Text[50])
        {
            Caption = 'FirstName';
            DataClassification = ToBeClassified;
        }
        field(3; LastName; Text[50])
        {
            Caption = 'LastName';
            DataClassification = ToBeClassified;
        }
        field(4; Email; Text[250])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }

}
