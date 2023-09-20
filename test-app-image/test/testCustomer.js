process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

const chai = require("chai");
const assert = chai.assert;
const expect = chai.expect;
const progress = require("@progress/jsdo-core").progress;


chai.should();

var jsdo;
var result,
    newCustNum,
    balance;

describe("Test Customer", () => {
    const options = {
        serviceURI: "https://ec2-3-84-2-121.compute-1.amazonaws.com:8811/Sports",
        catalogURI: "https://ec2-3-84-2-121.compute-1.amazonaws.com:8811/Sports/static/SportsService.json",
        resourceName: "Customer",
        authenticationModel: "anonymous"
    };

    before(function (done) {
        progress.data.getSession(options).then((object) => {
            jsdo = new progress.data.JSDO({
                name: options.resourceName
            });
        }, (error) => {
            throw new error("Error creating session");
        }).then(() => done(), () => done());
    });
    describe("Create Customer", () => {
        before(function (done) {
            jsdo.add({
                Name: "Test Customer",
                SalesRep: "BBB",
                Balance: 10000
            });
            jsdo.saveChanges(true).then((object) => {
                result = object;
                // console.log("DEBUG: SUCCESS: Result: ", result.request.jsrecords[0].data);
                newCustNum = result.request.jsrecords[0].data.CustNum;
            }, (object) => {
                result = object;
                // console.log("DEBUG: ERROR: Result: ", result);                
            }).then(() => done(), () => done());
        });

        it("should return an object", () => {
            result.should.be.an("object");
        });
        it("should return success", () => {
            result.success.should.equals(true);
        });
        it("should return a CustNum greater than zero", () => {
            newCustNum.should.be.at.least(1);
        });        
        it("new record should be returned by read() operation", (done) => {
            jsdo.read({
                filter: {
                    field: "CustNum",
                    operator: "eq",
                    value: newCustNum
                }
            }).then(() => {
                // console.log("DEBUG: SUCCESS: ");
                if (jsdo.getData().length === 1) {
                    done();
                } else {
                    done(new Error("Record not found"));
                }
            }, () => {
                // console.log("DEBUG: ERROR: ");
                done(new Error("Error reading records"));
            });
        });
    });
    describe("Read Customer", () => {
        before(function (done) {
            jsdo.read().then((object) => {
                result = object
            }, (object) => {
                result = object
            }).then(() => done(), () => done());
        });

        it("should return an object", () => {
            result.should.be.an("object");
        });
        it("should return a number of records greater than zero", () => {
            jsdo.getData().length.should.be.at.least(1);
        });        
    });
    describe("Update Customer", () => {
        before(function (done) {
            var jsrecord = jsdo.find((record) => {
                return record.data.CustNum === newCustNum;
            });
            jsrecord.assign({ Balance: 12345 });
            jsdo.saveChanges(true).then((object) => {
                result = object;
                balance = result.request.jsrecords[0].data.Balance;
            }, (object) => {
                result = object;
            }).then(() => done(), () => done());
        });
        it("should return an object", () => {
            result.should.be.an("object");
        });
        it("should return success", () => {
            result.success.should.equals(true);
        });
        it("should return a Balance equals to 12345", () => {
            balance.should.equals(12345);
        }); 
        it("Updated record is returned by read() operation", (done) => {
            jsdo.read({
                filter: {
                    field: "CustNum",
                    operator: "eq",
                    value: newCustNum
                }
            }).then(() => {
                // console.log("DEBUG: SUCCESS: ");
                if (jsdo.getData().length === 1
                    && jsdo.getData()[0].Balance === 12345) {
                    done();
                } else {
                    done(new Error("Matching record was not found"));
                }
            }, () => {
                // console.log("DEBUG: ERROR: ");
                done(new Error("Error reading records"));
            });
        });        
    });
    describe("Delete Customer", () => {
        before(function (done) {
            var jsrecord = jsdo.find((record) => {
                return record.data.CustNum === newCustNum;
            });
            jsrecord.remove();
            jsdo.saveChanges(true).then((object) => {
                result = object;
            }, (object) => {
                result = object;
            }).then(() => done(), () => done());
        });
        it("should return an object", () => {
            result.should.be.an("object");
        });
        it("should return success", () => {
            result.success.should.equals(true);
        });
        it("deleted record should not be returned by read() operation", (done) => {
            jsdo.read({
                filter: {
                    field: "CustNum",
                    operator: "eq",
                    value: newCustNum
                }
            }).then(() => {
                // console.log("DEBUG: SUCCESS: ");
                if (jsdo.getData().length === 1) {
                    done(new Error("Record was found"));                    
                } else {
                    done();
                }
            }, () => {
                // console.log("DEBUG: ERROR: ");
                done(new Error("Error reading records"));
            });
        });
    });    
});
