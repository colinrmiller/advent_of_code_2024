from typing import Union
import requests
import httpx
from pathlib import Path
from datetime import datetime
import sys
import os

year = 2024

_BASE_URL = "https://adventofcode.com/{year}/day/{}/input"
_SESSION_FILE_NAME = "session.txt"

with open('.cookie', 'r') as file:
    cookie = file.read().strip()
import sys
sys.argv += '01'.split()

os.cwd = os.path.dirname(os.path.abspath(__file__))

# day = sys.argv[2]
day = sys.argv[1]
paddedDay = f"0{day}" if len(day) == 1 else day

# print(f"Getting input from {input_url}")
# def _set_read_file(filename: str, default: str = None) -> Union[str, None]:
#     try:
#         with open("day" + filename) as file:
#             return file.read()
#     except FileNotFoundError:
#         if default:
#             with open(filename, "w") as file:
#                 file.write(default)
#                 return default
#         return None


# SESSION = _set_read_file('.cookie')
# if not SESSION:
#     SESSION = _set_read_file(
#         _SESSION_FILE_NAME,
#         input("Enter your session cookie: "))
# assert SESSION is not None
# SESSION = SESSION.strip()


def get_input(day: int, year: int = year, overwrite: bool = False):
    newDirectory = os.path.join(os.cwd, f'day{paddedDay}')
    
    if not os.path.exists(newDirectory):
        os.makedirs(newDirectory)

    file_name = os.path.join(f"day{paddedDay}", "input.txt")
    solve_file = os.path.join(f"day{paddedDay}", "solve.m")
    test_file = os.path.join(f"day{paddedDay}", "test.txt")

    response = requests.get(
            f"https://adventofcode.com/{year}/day/{day}/input",
            cookies={"session": cookie})
    if not response.ok:
        # if response.status_code == 404:
        #     raise FileNotFoundError(response.text)
        raise RuntimeError(f"Request failed, code: {response.status_code}, message: {response.content}")
        # data = _set_read_file(
        #     file_name,
        #     response.text[:-1])

    with open(file_name, 'w') as file:
        file.write(response.text)
    with open(solve_file, 'w') as file:
        file.write(f"% Solve day {day} part 1\n% https://adventofcode.com/{year}/day/{day}\naddpath('../helpers');\nimport helpers.*;")
    with open(test_file, 'w') as file:
        file.write(" ")
    return

# file = _set_read_file(input.txt)
get_input(day, year)