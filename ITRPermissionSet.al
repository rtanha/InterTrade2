permissionset 50000 ITRPermissionSet
{
    Assignable = true;
    // IncludedPermissionSets = SomePermissionSet;
    Permissions =

        tabledata Batch = RIMD,
        tabledata "Business Partner Role" = RIMD,
        tabledata "Business Partner Type" = RIMD,
        tabledata "Customer Item No." = RIMD,
        tabledata "Document Text" = RIMD,
        tabledata "Document Type" = RIMD,
        tabledata "Print Document" = RIMD,
        tabledata "Sea Route" = RIMD;

}