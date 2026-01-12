from pymol import cmd
import csv
import numpy as np

reference = "VL9_LIL"  #VAR#
models = ['VL9_LIL', 'VL9_LFL', 'HSP60', 'HCV', 'ENV6', 'GAG371', 'ENV797', 'ENV804', 'ENV814', 'GAG146', 'GAG276', 'POL279']    #VAR#

#Get CA atoms of reference
ref_atoms = cmd.get_model(f"{reference} and name CA").atom

output = []

print(f"Calculating RMSD per residue comparing to the reference")



for atom in ref_atoms:
    resi = atom.resi
    resn = atom.resn
    chain = atom.chain
    atom_name = atom.name  

    row = [resi, resn, chain]

    #Get reference coordinate
    ref_coord = cmd.get_atom_coords(f"{reference} and name {atom_name} and resi {resi} and chain {chain}")

    for model in models:
        # Try to get coordinate of the model at same residue
        sel = f"{model} and name {atom_name} and resi {resi} and chain {chain}"
        try:
            coord = cmd.get_atom_coords(sel)
            dist = np.linalg.norm(np.array(ref_coord) - np.array(coord))
        except:
            dist = "NA"
        row.append(dist)

    output.append(row)



#Write CSV
csv_path = "~/Desktop/XXXX.csv"  #DIR#

with open(csv_path, "w", newline="") as f:
    writer = csv.writer(f)
    header = ["Residue Index", "Residue Name", "Chain"] + models
    writer.writerow(header)
    writer.writerows(output)


print(f"RMSD per residue saved on Desktop")
