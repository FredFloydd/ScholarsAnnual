'''This program generates data for the simulation of a n-pendulum system. The total length of the system is 1m and the total mass is 1kg'''

import numpy as np
import math
from tqdm import tqdm
import numba

def generate_variables(n, angles, variables, masses):
	omega_vec = []
	acc_vec = []
	mass_coefficients = []
	for i in range(n):
		omega_vec.append(0.)
		acc_vec.append(0.)
		row = []
		for j in range(n):
			if j <= i:
				mass = 0
				for k in range(n - i):
					mass += masses[k]
				row.append(mass)
			else:
				mass = 0
				for l in range(j, n):
					mass += masses[l]
				row.append(mass)
		mass_coefficients.append(row)
	variables['thetas'] = np.array(angles)
	variables['omegas'] = np.array(omega_vec)
	variables['accs'] = np.array(acc_vec)
	variables['coeffs'] = np.array(mass_coefficients)

def calculate_matrices(coefficients, angles, omegas, n, g):
	acc_mat = []
	omg_mat = []
	grav_vec = []
	omgsq_vec = []

	for i in range(n):
		grav_vec.append(- g * coefficients[i][i] * math.sin(angles[i]))
		omgsq_vec.append(omegas[i] ** 2 / n)
		

	angle_sub = np.expand_dims(angles, 1) - np.expand_dims(angles, 0)
	acc_mat = np.cos(angle_sub)
	omg_mat = np.sin(angle_sub)

	mat1 = acc_mat 
	mat2 = omg_mat 
	mat3 = np.array(grav_vec)
	mat4 = np.array(omgsq_vec)
	acc_coeffs = np.multiply(mat1, coefficients)
	omg_coeffs = np.multiply(mat2, coefficients)
	mata = np.linalg.inv(acc_coeffs)
	matb1 = np.matmul(omg_coeffs, mat4)
	matb = mat3 - matb1
	totalmat = np.matmul(mata, matb)
	return totalmat

def run(n, g, masses, angles, time, ips, file1, file2):
	variables = {}
	generate_variables(n, angles, variables, masses)
	t = 1 / ips
	results = []
	masses = np.array(masses)
	np.savetxt(file1, masses, delimiter=",")
	frame_decider = ips / 100
	for i in tqdm(range(time * ips)):
		big = calculate_matrices(variables['coeffs'], variables['thetas'], variables['omegas'], n, g)
		variables['accs'] = n * big
		variables['accs'] = np.clip(variables['accs'], -1.0e10, 1.0e10)
		variables['omegas'] += variables['accs'] * t
		variables['omegas'] = np.clip(variables['omegas'], -1.0e10, 1.0e10)
		variables['thetas'] += variables['omegas'] * t

		if i % frame_decider == 0:
			results.append(variables['thetas'].copy())

	results = np.array(results)
	np.savetxt(file2, results, delimiter=",")
	return results

number = 100
iterations = 10000000
time = 30

masses = []
angles = []
theta =  math.pi/4
for n in range(number):
	masses.append(1/number)
	angles.append(theta)

run(number, 9.81, masses, angles, time, iterations, 'MassData.csv', 'AngleData.csv')
