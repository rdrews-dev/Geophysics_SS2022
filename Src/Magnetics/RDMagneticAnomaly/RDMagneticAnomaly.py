import numpy as np
from matplotlib import pyplot as plt

def dipole(m, r, r0):
    """Calculate a field in point r created by a dipole moment m located in r0.
    Spatial components are the outermost axis of r and returned B.
    """
    # we use np.subtract to allow r and r0 to be a python lists, not only np.array
    R = np.subtract(np.transpose(r), r0).T
    
    # assume that the spatial components of r are the outermost axis
    norm_R = np.sqrt(np.einsum("i...,i...", R, R))
    
    # calculate the dot product only for the outermost axis,
    # that is the spatial components
    m_dot_R = np.tensordot(m, R, axes=1)

    # tensordot with axes=0 does a general outer product - we want no sum
    B = 3 * m_dot_R * R / norm_R**5 - np.tensordot(m, 1 / norm_R**3, axes=0)
    
    # include the physical constant
    B *= 1e-7

    return B

InclinationInDegrees = -60.0
DipoleMomentMagnitude = 0.1
DipoleDepth = 2.0
DipoleHorizontal = 0.0
BoMagnitude = 1.0
mx = np.cos(InclinationInDegrees* np.pi / 180.)*DipoleMomentMagnitude
my = np.sin(InclinationInDegrees* np.pi / 180.)*DipoleMomentMagnitude

X = np.linspace(-100, 100)
Y = np.linspace(-100, 100)

XX,YY = np.meshgrid(X, Y)

Box = XX*0+np.cos(InclinationInDegrees* np.pi / 180.)*BoMagnitude
Boy = XX*0+np.sin(InclinationInDegrees* np.pi / 180.)*BoMagnitude


Bx, By = dipole(m=[mx, my], r=np.meshgrid(X, Y), r0=[DipoleHorizontal,-DipoleDepth])

plt.figure(figsize=(8, 8))
plt.streamplot(X, Y, Bx, By)
plt.streamplot(X, Y, Box, Boy)
plt.xlim([np.min(X),np.max(X)])
plt.xlim([np.min(Y),np.max(Y)])



plt.show()