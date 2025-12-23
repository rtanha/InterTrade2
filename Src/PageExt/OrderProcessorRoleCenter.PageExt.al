pageextension 50010 "Order Processor RC Ext (INT)" extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Action76)
        {
            group(ReportsINT)
            {
                Caption = 'Berichte';
                action(ABNumber)
                {
                    Caption = 'A/B Nummer';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "A/B Nummer";
                }
                action(BestandsPlanung)
                {
                    Caption = 'Bestandsplanung';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report Bestandsplanung;
                }
                action(Lagerabgrenzung)
                {
                    Caption = 'Lagerabgrenzung';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report Lagerabgrezung;
                }
                action(ChargenListeNachLagerort)
                {
                    Caption = 'Chargen-Liste nach Lagerort';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "Lot List";
                }
                action(Auftragsanalyse)
                {
                    Caption = 'Auftragsanalyse';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report Auftragsanalyse;
                }
                action(AuftragsanalysePartie)
                {
                    Caption = 'Auftragsanalyse Partie';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "Auftragsanalyse Partie";
                }
                action(PreisListe)
                {
                    Caption = 'Preisliste Intertrade';
                    Image = Report;
                    ApplicationArea = All;
                    RunObject = Report "VK-Preisliste Intertrade";
                }
            }
        }
    }

    var
        myInt: Integer;
}