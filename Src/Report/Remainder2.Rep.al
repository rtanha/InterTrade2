reportextension 50000 "Remainder Int" extends Reminder
{
    dataset
    {
        add(Integer)
        {
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo__Giro_No__; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfo__Bank_Name_; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfo__Bank_Account_No__; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
            {
            }
            column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
            {
            }
            column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
            {
            }

            column(Company_IBAN; CompanyInfo.IBAN)
            {
            }
            column(Company_Swift; CompanyInfo."SWIFT Code")
            {
            }
            column(Company_Email; CompanyInfo."E-Mail")
            {
            }
            column(Company_HomePage; CompanyInfo."Home Page")
            {
            }
            column(Company_USAccount; CompanyInfo."US Account (INT)")
            {
                IncludeCaption = true;
            }
            column(Company_RegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Giro_No__Caption; CompanyInfo__Giro_No__CaptionLbl)
            {
            }
            column(CompanyInfo__Bank_Account_No__Caption; CompanyInfo__Bank_Account_No__CaptionLbl)
            {
            }


        }

    }
    var
        CompanyInfo__Phone_No__CaptionLbl: TextConst DEU = 'Telefonnr.', ENU = 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: TextConst DEU = 'Faxnr.', ENU = 'Fax No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: TextConst DEU = 'USt-IdNr.', ENU = 'VAT Reg. No.';
        CompanyInfo__Giro_No__CaptionLbl: TextConst DEU = 'Postgirokontonr.', ENU = 'Giro No.';
        CompanyInfo__Bank_Name_CaptionLbl: TextConst DEU = 'Bankkonto', ENU = 'Bank';
        CompanyInfo__Bank_Account_No__CaptionLbl: TextConst DEU = 'Steuernummer:', ENU = 'Registration No.:';

}