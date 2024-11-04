**Ticket Summary**

The goal is to implement a Lambda function that routes transactions to the correct Terminal ID (TID) based on currency and channel type. The logic is to determine the TID for transactions depending on:

    1. Currency (CAD or USD)
    2. Channel Type (Direct or Indirect)

**Logic Breakdown**

    1. If CAD and Direct Channel: Use the TID for "Flair Airlines Ecommerce CAD."
    2. If CAD and Indirect Channel: Use the TID for "Flair Airlines MOTO CAD."
    3. If USD and Direct Channel: Use the TID for "Flair Airlines Ecommerce USD."
    4. If USD and Indirect Channel: Use the TID for "Flair Airlines MOTO USD."

**Terminal IDs Provided**

The second screenshot shows the TID mapping for each condition:

    1. Flair Airlines Ecommerce USD - TID: 0017340008025557375191
    2. Flair Airlines MOTO USD - TID: 0017340008025557391040
    3. Flair Airlines Ecommerce CAD - TID: 0089250008025557433284
    4. Flair Airlines MOTO CAD - TID: 0089250008025557441121

**Required Inputs and Outputs**

**Inputs:**

    1. Currency Type (CAD or USD)
    2. Channel Type (Direct or Indirect)

**Expected Output:**

The Lambda function should return the appropriate **Terminal ID** based on the input conditions (currency and channel type).

**Task Completion Expectations**

**Implementation** of a Lambda function that accepts `currency` and `channel` as inputs.
**Routing Logic** to determine and return the correct Terminal ID based on the provided conditions.
**Testing** to ensure each condition routes to the correct Terminal ID.

`In summary, this task requires creating a routing function in AWS Lambda that returns the correct TID depending on the input values of currency and channel type. Let me know if you'd like further guidance on writing the function or setting up the Lambda in AWS.`