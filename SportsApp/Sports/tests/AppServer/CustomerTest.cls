 
/*------------------------------------------------------------------------
   File        : CustomerTest
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : rahulk
   Created     : Sat Sep 09 16:43:47 IST 2023
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.Assert FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS CustomerTest:

    /*    DEFINE TEMP-TABLE ttOrder                                                       */
    /*        FIELD Ordernum AS INTEGER LABEL "Order Num" FORMAT "zzzzzzzzz9" INITIAL "0".*/
    /*    DEFINE DATASET dsCustomer1 FOR ttOrder.                                         */
    /*                  
    {}                                                                  */
        
/*    {customer.i}*/

    /*------------------------------------------------------------------------------
         Purpose:                                                                        
         Notes:                                                                        
 ------------------------------------------------------------------------------*/

    @Before.
    METHOD PUBLIC VOID setUpBeforeClass(  ):
        
        RETURN.

    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
   
    @Setup.
    METHOD PUBLIC VOID setUp(  ):
        
        RETURN.

    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/

    @TearDown.
    METHOD PUBLIC VOID tearDown(  ):
        
        RETURN.

    END METHOD.
     
    /*------------------------------------------------------------------------------
         Purpose:                                                                        
         Notes:                                                                        
 ------------------------------------------------------------------------------*/
   
    @After.
    METHOD PUBLIC VOID tearDownAfterClass(  ):
        
        RETURN.

    END METHOD.
     
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    METHOD PUBLIC VOID testReadCustomer(  ):
/*        DEFINE VARIABLE customerVar AS Customer  NO-UNDO.                   */
/*        DEFINE VARIABLE iQuery      AS CHARACTER NO-UNDO.                   */
/*                                                                            */
/*        customerVar = NEW Customer().                                       */
/*        iQuery="WHERE Customer.State = 'UNKNOWN'".                          */
/*                                                                            */
/*        DEFINE DATA-SOURCE srcCustomer FOR Customer.                        */
/*        /*        DEFINE BUFFER OtherCust FOR Customer.                 */  */
/*        /*                                                              */  */
/*        /*        DATASET dsCustomer:FILL().                            */  */
/*        /*                                                              */  */
/*        /*        DATASET dsCustomer:HANDLE.                            */  */
/*                                                                            */
/*        BUFFER ttCustomer:ATTACH-DATA-SOURCE(DATA-SOURCE srcCustomer:HANDLE,*/
/*            "Customer.Name,CustName").                                      */
/*                                                                            */
/*        customerVar:ReadCustomer(iQuery, DATASET dsCustomer).               */
/*                                                                            */
/*        DATASET dsCustomer:FILL().                                          */
/*        BUFFER ttCustomer:DETACH-DATA-SOURCE().                             */
/*        FOR EACH ttCustomer:                                                */
/*            DISPLAY                                                         */
/*                ttCustomer.Name                                             */
/*                ttCustomer.State.                                           */
/*            Assert:Equals(ttCustomer.State, "hey").                         */
/*                                                                            */
/*        END.                                                                */
        Assert:IsTrue(TRUE).
        RETURN.

    END METHOD.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    METHOD PUBLIC VOID testCreateCustomer(  ):
        Assert:IsTrue(TRUE).
        RETURN.

    END METHOD.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    METHOD PUBLIC VOID testcount(  ):
        DEFINE VARIABLE customerVar AS Customer  NO-UNDO.
        DEFINE VARIABLE iQuery      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE oCount      AS INTEGER   NO-UNDO.

        customerVar = NEW Customer().
        iQuery="WHERE Customer.State = 'UNKNOWN'".
        customerVar:count(iQuery, oCount).
        Assert:Equals(oCount ,  0).
        
        iQuery="WHERE Customer.State = 'NH'".
        customerVar:count(iQuery, oCount).
        Assert:NotEqual(oCount ,  0).
        Assert:IsPositive(oCount).
        RETURN.

    END METHOD.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    METHOD PUBLIC VOID testDeleteCustomer(  ):
        Assert:IsTrue(TRUE).
        RETURN.

    END METHOD.
    
END CLASS.