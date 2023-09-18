 
 /*------------------------------------------------------------------------
    File        : SportsTestSuite
    Syntax      : 
    Author(s)   : rahulk
    Created     : Sat Sep 09 16:41:21 IST 2023
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
BLOCK-LEVEL ON ERROR UNDO, THROW.

@TestSuite(classes= "CustomerTest, OrderTest").
CLASS SportsTestSuite: 

END CLASS.