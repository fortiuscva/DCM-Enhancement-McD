pageextension 50141 TOMGeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            /* field(BankReconwithAutoMatch; Rec."Bank Recon. with Auto. Match")
             {
                 ApplicationArea = All;
                 Caption = 'Bank Recon. with Auto. Match';
             }*/
            field(BankAccReconBatchName; Rec."Bank Acc. Recon. Batch Name")
            {
                ApplicationArea = All;
                Caption = 'Bank Acc. Recon. Batch Name';
            }
            field(BankAccReconTemplateName; Rec."Bank Acc. Recon. Template Name")
            {
                ApplicationArea = All;
                Caption = 'Bank Acc. Recon. Template Name';
            }
        }
    }
}
