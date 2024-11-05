import os
import json

def lambda_handler(event, context):
    # Extract input values from the event
    currency = event.get("currency")
    channel = event.get("channel")

    # Define the Terminal IDs using environment variables
    terminal_ids = {
        ("CAD", "Direct"): os.getenv("TERMINAL_ID_CAD_DIRECT"),
        ("CAD", "Indirect"): os.getenv("TERMINAL_ID_CAD_INDIRECT"),
        ("USD", "Direct"): os.getenv("TERMINAL_ID_USD_DIRECT"),
        ("USD", "Indirect"): os.getenv("TERMINAL_ID_USD_INDIRECT")
    }

    # Find the Terminal ID based on the currency and channel input
    tid = terminal_ids.get((currency, channel))

    # Check if TID was found; if not, return an error message
    if tid:
        return {
            "statusCode": 200,
            "body": {
                "message": "Terminal ID found",
                "currency": currency,
                "channel": channel,
                "terminal_id": tid
            }
        }
    else:
        return {
            "statusCode": 400,
            "body": {
                "message": "Invalid input: No matching Terminal ID",
                "currency": currency,
                "channel": channel
            }
        }
