#! /bin/bash -f
echo "Hi there please Enter PDB file name with path: " 
read pdb_file
echo "calculating distances ###################################### wait for a while"
cat $pdb_file |
awk  '($1 == "ATOM" && $3 == "CA") || \
($1 == "HETATM" && $3 == "O")
{
	atom[$2] = 1
	x[$2] = $7
	y[$2] = $8
	z[$2] = $9
	name[$2] = $4
	}
	END {
		for(a in atom)
		{
			for(b in atom)
			{
				if(a > b && name[a] != name[b])
				{
					dist = sqrt((x[a]-x[b])^2 + (y[a]-y[b])^2 + (z[a]-z[b])^2)
					if (dist <= 3.5)
					{
						printf"--------------------------------------------------\n"
                        			printf "C-alpha no: %s <--> HOH no: %s: ----  %.4f\n", a, b, dist
					}
				}
			}
		}
	}' | awk '/C-alpha/ {print $0}' > result.txt
echo "Writing C-alpha atoms"
echo "Writing HOH Hetero atoms"
echo "writing distances ##################"
echo "complete !!!"
echo "all the results are written to result.txt"
echo "Thank you. Have a nice day - Gannu" 
