import os
import json

def lambda_handler(event, context):
    # Parse the input parameters from API Gateway
    try:
        body = json.loads(event["body"])
        currency = body.get("currency")
        channel = body.get("channel")
    except (json.JSONDecodeError, KeyError) as e:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid request format"})
        }
    
    # Define the terminal IDs for each condition
    terminal_ids = {
        ("CAD", "Direct"): os.getenv("TERMINAL_ID_CAD_DIRECT"),
        ("CAD", "Indirect"): os.getenv("TERMINAL_ID_CAD_INDIRECT"),
        ("USD", "Direct"): os.getenv("TERMINAL_ID_USD_DIRECT"),
        ("USD", "Indirect"): os.getenv("TERMINAL_ID_USD_INDIRECT")
    }
    
    # Determine the appropriate Terminal ID based on the currency and channel
    terminal_id = terminal_ids.get((currency, channel))
    
    # Check if a valid Terminal ID was found
    if terminal_id:
        return {
            "statusCode": 200,
            "body": json.dumps({"terminalID": terminal_id})
        }
    else:
        # Return an error if currency/channel combination is invalid
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid currency or channel"})
        }
