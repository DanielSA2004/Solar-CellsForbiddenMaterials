#solardb_utils.py

from mpcontribs.client import Client
import os
import pandas as pd
from dotenv import load_dotenv

api_key = os.getenv("API_KEY")
client = Client(apikey="api_key", project="ForbiddenTransitions")

def Checkfile_Params():
    if os.path.exists("parametros_disponibles.csv"):
        print('parametros_disponibles.csv ya existe')
    else:
        params = client.available_query_params()
        df = pd.DataFrame(params, columns=["Parametro"])
        df.to_csv("parametros_disponibles.csv", index=False)
        print("Parámetros guardados en parametros_disponibles.csv")

def Params_filter():
    params = pd.read_csv("parametros_disponibles.csv")
    propiedades = [p for p in params["Parametro"] if "__" not in p]
    propiedades_principales = [p for p in propiedades if p.startswith("data.properties")]

    print("Propiedades principales disponibles:")
    for p in propiedades_principales:
        print("-", p)


def CreateDatabase():
    if os.path.exists('materiales_propiedades.xlsx'):
        print('file already exists')
    else:
        fields = [
            "identifier",
            "formula",
            "data.properties.optical.bandgaps.GGA",
            "data.properties.optical.type",           
            "data.properties.other.synthesized",
            "data.properties.chemical.sigma"
        ]



        print("Descargando datos de la API...")
        raw = client.query_contributions(fields=fields, paginate=True)

        # "raw" es un diccionario con "total_count" y "data"
        # lo que quieres está dentro de "data"
        data = raw["data"] if "data" in raw else raw  

        # Normalizar cada entrada en columnas
        df = pd.json_normalize(data)

        # Guardar en CSV y Excel
        df.to_csv("materiales_propiedades.csv", index=False)
        df.to_excel("materiales_propiedades.xlsx", index=False, engine="openpyxl")
        print(f"Base completa guardada con {len(df)} registros")

        # Filtrar sintetizables si la columna existe
        synth_col = "data.properties.other.synthesized"
        if synth_col in df.columns:
            df_sint = df[df[synth_col].fillna("") == "Yes"].copy()
            df_sint.to_csv("materiales_propiedades_sintetizables.csv", index=False)
            df_sint.to_excel("materiales_propiedades_sintetizables.xlsx", index=False, engine="openpyxl")
            print(f"Base filtrada guardada con {len(df_sint)} registros sintetizables")
        else:
            print("La columna 'data.properties.other.synthesized' no apareció en este batch de datos")

def FiltrarSintetizables():
    path = "materiales_propiedades.csv"
    if not os.path.exists(path):
        print(f"No se encontró {path}")
        return

    df = pd.read_csv(path)

    synth_col = "data.properties.other.synthesized"
    bandgap_val_col = "data.properties.optical.bandgaps.GGA.value"
    tipo_col = "data.properties.optical.type"

    # Verifica columnas esenciales
    missing = [c for c in [synth_col, bandgap_val_col, tipo_col] if c not in df.columns]
    if missing:
        print("Faltan columnas necesarias:", missing)
        print("Columnas disponibles:", df.columns.tolist())
        return

    # filtrar sintetizables
    synth_vals = df[synth_col].fillna("").astype(str).str.strip().str.lower()
    synth_mask = synth_vals.isin(["yes", "si", "true", "1", "y"])

    # Filtrar bandgap en rango 1.0–1.8 eV
    bg = pd.to_numeric(df[bandgap_val_col], errors="coerce")
    bg_mask = bg.ge(1.0) & bg.le(1.8)

    # Filtrar tipo = 'da' (direct allowed)
    tipo_vals = df[tipo_col].fillna("").astype(str).str.strip().str.lower()
    tipo_mask = tipo_vals.eq("da")

    # --- Aplicar TODOS los filtros ---
    df_final = df[synth_mask & bg_mask & tipo_mask].copy()

    # Guardar solo Excel
    output_path = "materiales_filtrados.xlsx"
    df_final.to_excel(output_path, index=False, engine="openpyxl")

    print(f"Base final guardada en '{output_path}' con {len(df_final)} registros sintetizables, "
          f"bandgap 1–1.8 eV y tipo 'da'")
