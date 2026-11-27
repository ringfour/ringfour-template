"""Write the configured greeting to the App run output."""

import os


if __name__ == "__main__":
    print(os.environ.get("GREETING", "Hello from Ringfour!"), flush=True)
