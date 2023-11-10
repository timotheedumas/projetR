import pandas as pd
import numpy as np

df = pd.read_csv("ufo-sightings-transformed.csv")

df2 = df.dropna(axis=0)

df2.drop("Encounter_Duration", axis = 1 , inplace = True)
df2.drop("Unnamed: 0", axis = 1, inplace = True)
df2["length_of_encounter_seconds"] = df2["length_of_encounter_seconds"].astype(float)
df2["length_of_encounter_minutes"] = (df2["length_of_encounter_seconds"] / 60).astype(np.int64)

# Enregistrement du DataFrame nettoyé dans un nouveau fichier CSV
df2.to_csv("clean-ufo-sightings-transformed.csv", index=False)

