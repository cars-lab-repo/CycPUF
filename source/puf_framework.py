# -*- coding: utf-8 -*-
"""
@author: Michael Dominguez
"""
import random
from puf_defs import *

print("Pick the number that corresponds with the PUF design you desire.")
print("    1. Arbiter PUF (APUF)")
print("    2. Ring Oscillator PUF (ROPUF)")
print("    3. Butterfly PUF")

puf_design = int(input("Type 1, 2, or 3: "))

print("\nWill this PUF be a CycPUF or Template PUF?")
print("    1. Acyclic please!")
print("    2. ¡CycPUF por favor!")
print("    3. I'd like a Template PUF!")

cyclic = int(input("Type 1, 2, or 3: "))


print("\nWill this PUF have a multi-bit response?")

multi_bit = input("Type (y)es or (n)o: ")
multi_bit = multi_bit[0]

size_of = int(input("Enter the size of Challenge vector (an integer): ")) - 1

try:
    if ((((size_of + 1)%2) != 0) or (size_of < 1)) and (puf_design == 2):
        raise ValueError("Error: size of Challenge vector for ROPUF must be an even number and at least 2.")
    elif (size_of < 0):
        raise ValueError("Error: size of Challenge vector must be at least 1.")

except ValueError as err:
    print(f"\n{err} Please run the program again and correct the error.")
            
else:
    if (cyclic == 1):
        if (multi_bit == "n"):
            if (puf_design == 1):
                onebitApufTopModule(size_of)
                print(f"\nYou chose single-bit response, acyclic APUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
            
            elif (puf_design == 2):
                twobitRopufTopModule(size_of)
                print(f"\nYou chose two-bit response, acyclic ROPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")

            elif (puf_design == 3):
                onebitBpufTopModule(size_of)
                print(f"\nYou chose single-bit response, acyclic BPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
    
        elif (multi_bit == "y"):
            if (puf_design == 1):
                multibitApufTopModule(size_of)
                print(f"\nYou chose multi-bit response, acyclic APUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")

            elif (puf_design == 2):
                multibitRopufTopModule(size_of)
                print(f"\nYou chose multi-bit response, acyclic ROPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
        
            elif (puf_design == 3):
                multibitBpufTopModule(size_of)
                print(f"\nYou chose multi-bit response, acyclic BPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
        
    elif (cyclic == 2):
        num_cyc = int(input("Enter the number of cycles (an integer): ")) - 1
        try:
            if ((((num_cyc + 1)%2) != 0) or (size_of < 1)) and (puf_design == 2):
                raise ValueError("Error: Number of cycles for ROPUF must be an even number and at least 2 and cannot equal the Challenge vector size.")
            
            elif (num_cyc < 0):
                raise ValueError("Error: Number of cycles must be at least 1 and cannot equal the Challenge vector size.")
                
        except ValueError as err:
            print(f"\n{err} Please run the program again and correct the error.")
                    
        else:
            if (multi_bit == "n"):
                if (puf_design == 1):
                    onebitCycApufTopModule(size_of, num_cyc)
                    print(f"\nYou chose single-bit response, cyclic APUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")

                elif (puf_design == 2):
                    twobitCycRopufTopModule(size_of, num_cyc)
                    print(f"\nYou chose two-bit response, cyclic ROPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
                
                elif (puf_design == 3):
                    onebitCycBpufTopModule(size_of, num_cyc)
                    print(f"\nYou chose single-bit response, cyclic BPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
        
            elif (multi_bit == "y"):
                if (puf_design == 1):
                    multibitCycApufTopModule(size_of, num_cyc)
                    print(f"\nYou chose multi-bit response, cyclic APUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
                
                elif (puf_design == 2):
                    multibitCycRopufTopModule(size_of, num_cyc)
                    print(f"\nYou chose multi-bit response, cyclic ROPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
                
                elif (puf_design == 3):
                    multibitCycBpufTopModule(size_of, num_cyc)
                    print(f"\nYou chose multi-bit response, cyclic BPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")

    elif (cyclic == 3):
        num_cyc = int(input("Enter the number of cycles (an integer): ")) - 1
        try:
            if ((((num_cyc + 1)%2) != 0) or (size_of < 1)) and (puf_design == 2):
                raise ValueError("Error: Number of cycles for ROPUF must be an even number and at least 2 and cannot equal the Challenge vector size.")
            
            elif (num_cyc < 0):
                raise ValueError("Error: Number of cycles must be at least 1 and cannot equal the Challenge vector size.")
                
        except ValueError as err:
            print(f"\n{err} Please run the program again and correct the error.")
                    
        else:
            if (multi_bit == "n"):
                if (puf_design == 1):
                    onebitCycApufTopModule(size_of, num_cyc)
                    print(f"\nYou chose single-bit response, cyclic APUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")

                elif (puf_design == 2):
                    twobitCycRopufTopModule(size_of, num_cyc)
                    print(f"\nYou chose two-bit response, cyclic ROPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
                
                elif (puf_design == 3):
                    onebitCycBpufTopModule(size_of, num_cyc)
                    print(f"\nYou chose single-bit response, cyclic BPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
        
            elif (multi_bit == "y"):
                if (puf_design == 1):
                    templateApufTopModule(size_of, num_cyc)
                    print(f"\nYou chose multi-bit response, Template APUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
                
                elif (puf_design == 2):
                    templateRopufTopModule(size_of, num_cyc)
                    print(f"\nYou chose multi-bit response, Template ROPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
                
                elif (puf_design == 3):
                    templateBpufTopModule(size_of, num_cyc)
                    print(f"\nYou chose multi-bit response, Template BPUF with a {size_of + 1} bit Challenge vector. Your verilog files have been generated in the current directory.")
