codeunit 60100 APIManagement
{
    procedure CallAPI(ParMethodType: text; ParMethod: Text; ParData: Text; Var ParAPIResponseTxt: Text; Var ParHttpResponse: HttpResponseMessage) RetSucess: Boolean;
    var
        Base64ConvMgt: Codeunit "Base64 Convert";
        RequestUriLble: Label '%1%2';
        RequestUriTxt: Text;
        gHttpContent: HttpContent;
        gHttpClient: HttpClient;
        gHeaders: HttpHeaders;
        APIRequestMsg: HttpRequestMessage;
        APIResponseMsg: HttpResponseMessage;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
        Success: Boolean;
        ErrorMsg: text;
        AuthContent: text;
        i: Integer;
        j: Integer;
        TempBlob: Record TempBlob temporary;
    begin
        RetSucess := True;

        APIRequestMsg.Method := ParMethodType;
        RequestUriTxt := StrSubstNo(RequestUriLble, ParMethod, '');
        RequestUriTxt := ConvertTextToURI(RequestUriTxt);
        RequestUriTxt := StrSubstNo(RequestUriLble, 'http://bc16au:7048/BC/api/hp/apiproject/v1.0/companies(5688d224-a980-ea11-bb48-000d3a299a02)/', RequestUriTxt);

        case ParMethodType of
            'POST':
                begin
                    gHttpContent.WriteFrom(ParData);
                    gHttpContent.GetHeaders(gHeaders);
                    APIRequestMsg.Content(gHttpContent);
                    gHeaders.Remove('Content-Type');
                    gHeaders.Add('Content-Type', 'application/json');
                    APIRequestMsg.GetHeaders(gHeaders);
                    AuthContent := StrSubstNo(AuthContentLbl, 'admin', 'admin');
                    TempBlob.WriteAsText(AuthContent, TextEncoding::UTF8);
                    gHeaders.Add(AuthorizationLbl, StrSubstNo(AuthType_Lbl, Base64ConvMgt.ToBase64(AuthContent)));
                    APIRequestMsg.Content(gHttpContent);
                    APIRequestMsg.Method('Post');
                    APIRequestMsg.SetRequestUri(RequestUriTxt);
                end;
            'GET':
                begin
                    APIRequestMsg.GetHeaders(gHeaders);
                    AuthContent := StrSubstNo(AuthContentLbl, 'admin', 'admin');
                    TempBlob.WriteAsText(AuthContent, TextEncoding::UTF8);
                    gHeaders.Add(AuthorizationLbl, StrSubstNo(AuthType_Lbl, Base64ConvMgt.ToBase64(AuthContent)));
                    APIRequestMsg.SetRequestUri(RequestUriTxt);
                end;
            'DELETE':
                begin
                    APIRequestMsg.GetHeaders(gHeaders);
                    AuthContent := StrSubstNo(AuthContentLbl, 'admin', 'admin');
                    TempBlob.WriteAsText(AuthContent, TextEncoding::UTF8);
                    gHeaders.Add(AuthorizationLbl, StrSubstNo(AuthType_Lbl, Base64ConvMgt.ToBase64(AuthContent)));
                    APIRequestMsg.SetRequestUri(RequestUriTxt + '(' + ParData + ')');
                end;
        end;

        If Not gHttpClient.Send(APIRequestMsg, APIResponseMsg) then begin
            if APIResponseMsg.HttpStatusCode <> 200 then begin
                RetSucess := False;
                ERROR(ApiCallFailedLbl);
            end;
        end;

        if not APIResponseMsg.IsSuccessStatusCode() then begin
            RetSucess := False;
            Commit();
            Error(StrSubstNo(ApiErrorStatusDescLbl, APIResponseMsg.HttpStatusCode(), APIResponseMsg.ReasonPhrase()))
        end;

        if APIRequestMsg.Method = 'GET' then begin
            APIResponseMsg.Content().ReadAs(JsonText);
            Message(JsonText);
        end;

        IF (APIResponseMsg.HttpStatusCode = 200) or (APIREsponseMsg.HttpStatusCode = 201) or (APIResponseMsg.HttpStatusCode = 204) Then
            Success := True;

        ParHttpResponse := APIResponseMsg;
        ParAPIResponseTxt := JsonText;
    end;

    procedure ConvertTextToURI(ParTxt: text) NewString: Text
    begin
        NewString := ParTxt.Replace(':', '%3A');
        NewString := NewString.Replace('\', '%5C');
    end;

    var
        AuthorizationLbl: Label 'Authorization';
        AuthType_Lbl: Label 'Basic %1';
        ApiCallFailedLbl: Label 'Api call is failed.';
        ApiErrorStatusDescLbl: Label 'The api returned an error message:\Status code: %1\ Description: %2';
        ApiCallErrorLbl: Label 'The api returned an error message:\';
        HttpStatusLbl: Label 'Status code: %1\';
        DescriptionLbl: Label 'Description: %2';
        JsonTokenLbl: Label 'Could not find a token with key %1';
        LastFileFoundLbl: Label '%1 file is found in Inbound folder.';
        GetFileData_Lbl: Label 'Data is found in %1.';
        ArchiveFile_Lbl: Label 'File %1 has been successfully processed and moved to archive folder.';
        FailedFile_Lbl: Label 'File %1 has been moved in failed folder due to failure in process.';
        AuthContentLbl: Label '%1:%2';
}