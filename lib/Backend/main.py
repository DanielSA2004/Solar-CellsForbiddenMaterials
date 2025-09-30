# main.py
from solardb_utils import Checkfile_Params, Params_filter, CreateDatabase, FiltrarSintetizables

if __name__ == "__main__":
    Checkfile_Params()
    Params_filter()
    CreateDatabase()
    FiltrarSintetizables()

