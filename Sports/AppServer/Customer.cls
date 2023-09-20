@program FILE(name="Customer.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="Customer", URI="/Customer", schemaName="dsCustomer", schemaFile="Sports/AppServer/customer.i").

USING Progress.Lang.*.

USING OpenEdge.BusinessLogic.BusinessEntity.
USING Progress.Json.ObjectModel.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Customer INHERITS BusinessEntity:

    {"customer.i"}
    
    DEFINE DATA-SOURCE srcCustomer FOR Customer.
  
    DEFINE VARIABLE iSeq AS INTEGER NO-UNDO.

    CONSTRUCTOR PUBLIC Customer():
        
        DEFINE VAR hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VAR cSkipListArray   AS CHAR   NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsCustomer:HANDLE).
        
        /* Data Source for each table in dataset. 
           Should be in table order as defined in DataSet */
        hDataSourceArray[1] =  DATA-SOURCE srcCustomer:HANDLE.

        /* Skip-list entry array for each table in DataSet.
           Should be in temp-table order as defined in DataSet */ 
        /* Each skip-list entry is a comma-separated list of field names
           to be ignored in the CREATE statement */

        cSkipListArray[1] = "CustNum".

        THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.

    END CONSTRUCTOR.

    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    @openapi.openedge.method.property (name="mappingType", value="JFP").
    @openapi.openedge.method.property (name="capabilities", value="ablFilter,top,skip,id,orderBy").
    METHOD PUBLIC VOID ReadCustomer(
        INPUT filter AS CHARACTER, 
        OUTPUT DATASET dsCustomer):

       
    END METHOD.

    /* Other CUD and Submit operation methods */
    
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreateCustomer(INPUT-OUTPUT DATASET dsCustomer):            
               
        SUPER:CreateData(DATASET dsCustomer BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdateCustomer(INPUT-OUTPUT DATASET dsCustomer):            
    
        SUPER:UpdateData(DATASET dsCustomer BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeleteCustomer(INPUT-OUTPUT DATASET dsCustomer):                    
    
        SUPER:DeleteData(DATASET dsCustomer BY-REFERENCE).
    END METHOD.
    

    METHOD PRIVATE VOID JFPFillMethod(INPUT filter AS CHARACTER):
  
    END METHOD.
    
    METHOD PUBLIC VOID AddIdField (INPUT DATASET dsCustomer):
        ASSIGN  
            ttCustomer.id  = STRING(ROWID(Customer))
            iSeq           = iSeq + 1
            ttCustomer.seq = iSeq.
    END.

    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="invoke", URI="/count?filter=~{filter~}", alias="", mediaType="application/json").
    METHOD PUBLIC VOID count( INPUT filter AS CHARACTER, OUTPUT numRecs AS INTEGER):
        DEFINE VARIABLE jsonParser AS ObjectModelParser NO-UNDO.
        DEFINE VARIABLE jsonObject AS JsonObject        NO-UNDO.
        DEFINE VARIABLE ablFilter  AS CHARACTER         NO-UNDO.
        DEFINE VARIABLE cWhere     AS CHARACTER         NO-UNDO.
        DEFINE VARIABLE qh         AS HANDLE            NO-UNDO.

        IF filter BEGINS "WHERE " THEN
            cWhere = filter.
        ELSE IF filter BEGINS "~{" THEN 
            DO:
                jsonParser  = NEW ObjectModelParser().
                jsonObject  = CAST(jsonParser:Parse(filter), jsonObject).
                ablFilter   = jsonObject:GetCharacter("ablFilter") NO-ERROR.
                cWhere      = "WHERE " + ablFilter.
            END.
            ELSE IF filter NE "" THEN
                DO:
                    /* Use filter as WHERE clause */
                    cWhere = "WHERE " + filter.
                END.

        CREATE QUERY qh.
        qh:SET-BUFFERS(BUFFER Customer:HANDLE).
        qh:QUERY-PREPARE("PRESELECT EACH Customer " + cWhere).
        qh:QUERY-OPEN ().
        numRecs = qh:NUM-RESULTS.

    END METHOD.

    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="submit", URI="/SubmitSCustomer", alias="", mediaType="application/json").
    METHOD PUBLIC VOID SubmitCustomer(INPUT-OUTPUT DATASET dsCustomer):                      
        SUPER:Submit(DATASET dsCustomer BY-REFERENCE).
        FOR EACH ttCustomer:
            FIND FIRST customer WHERE customer.custnum = ttCustomer.custnum NO-LOCK NO-ERROR.
            IF AVAILABLE customer THEN 
            DO:
                ttCustomer.id = STRING(ROWID(Customer)).
            END.
        END.
    END METHOD.

END CLASS.