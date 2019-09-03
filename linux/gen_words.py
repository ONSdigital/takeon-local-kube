import random
import string

def gen_name():
    print(''.join(random.choice(string.ascii_lowercase) for _ in range(20)))

def gen_pass():
    print(''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(20)))
