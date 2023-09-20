 
/*------------------------------------------------------------------------
   File        : OrderTest
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : rahulk
   Created     : Sat Sep 09 19:40:47 IST 2023
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.Assert FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS OrderTest:
      
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    METHOD PUBLIC VOID testCreateOrder(  ):
        Assert:IsTrue(TRUE).
        RETURN.

    END METHOD.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                        
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @Test. 
    METHOD PUBLIC VOID testReadOrder(  ):
        Assert:IsTrue(TRUE).
        RETURN.

    END METHOD.
    
END CLASS.