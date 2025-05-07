import binascii
import os

print("AES_ENCRYPTION_KEY:", binascii.hexlify(os.urandom(32)).decode())
print("JWT_SECRET_KEY:", binascii.hexlify(os.urandom(32)).decode())