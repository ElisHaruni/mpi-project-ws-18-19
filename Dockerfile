FROM fedora:28
# install dependencies
RUN dnf -y install dropbear openmpi openmpi-devel passwd

# configure environment for openmpi
ENV PATH="${PATH}:/usr/lib64/openmpi/bin/"
ENV LD_LIBRARY_PATH="/usr/lib64/openmpi/lib"

# for passwordless login we simply remove the root password :)
RUN passwd -d root

# compile our MPI application
WORKDIR /root
COPY source/example.c .
RUN mpicc example.c

# expose port 22 and start lightweight ssh server by default
EXPOSE 22
CMD dropbear -F -B -R
