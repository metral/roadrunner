#!/usr/bin/env python
#===============================================================================
import subprocess
import os
import sys
#-------------------------------------------------------------------------------
def create_graphs_dir(instance_name):
    dirpath = os.path.dirname(sys.argv[0])
    
    cmd = subprocess.Popen("hostname", stdout = subprocess.PIPE, shell=True)
    cmd_output, cmd_error = cmd.communicate() 
    cmd_output = cmd_output.replace("\n", "")
    
    hostname = cmd_output
    instance_dirname = "_".join([hostname, instance_name])
    
    instance_dirpath = "/".join([dirpath, "output", instance_dirname])
    
    cmd_args = " ".join(["mkdir", instance_dirpath])
    cmd = subprocess.Popen(cmd_args, stdout = subprocess.PIPE, shell=True)
    cmd.communicate() 
    
    return instance_dirpath
#-------------------------------------------------------------------------------
def generate_graphs(instance_name, graphs_dirpath):
    dirpath = os.path.dirname(sys.argv[0])
    gen_graphs_path = '/'.join([dirpath, "generate_graphs.sh"])

    collectd_path = "/var/lib/collectd/rrd/%s/libvirt/" % (instance_name)
    
    cmd_args = " ".join([gen_graphs_path, collectd_path, graphs_dirpath])
    
    cmd = subprocess.Popen(cmd_args, stdout = subprocess.PIPE, shell=True)
    cmd.communicate()
#-------------------------------------------------------------------------------
def tar_graphs(graphs_dirpath):
    dirname = os.path.dirname(graphs_dirpath)     # ./scripts/output
    basename = os.path.basename(graphs_dirpath)   # compute_*
    tarball_name = ".".join([graphs_dirpath, "tar.gz"])  # compute_*.tar.gz
    
    cmd_args = " ".join(["tar", "-C", dirname, "-zcvf", tarball_name, basename])
    cmd = subprocess.Popen(cmd_args, stdout = subprocess.PIPE, shell=True)
    cmd.communicate() 

    cmd_args = " ".join(["rm", "-rf", graphs_dirpath])
    cmd = subprocess.Popen(cmd_args, stdout = subprocess.PIPE, shell=True)
    cmd.communicate() 
    
    return tarball_name
#-------------------------------------------------------------------------------
def check_collectd_path():
    collectd_path = "/var/lib/collectd/rrd/%s/libvirt/" % (instance_name)
    
    if not os.path.exists(collectd_path):
        sys.stderr.write('error\n')
        sys.exit(0);

    return collectd_path
#-------------------------------------------------------------------------------
def main():
    instance_name = sys.argv[1]
    collectd_path = check_collectd_path
        
    graphs_dirpath = create_graphs_dir(instance_name)
    
    generate_graphs(instance_name, graphs_dirpath)
    tarball_name = tar_graphs(graphs_dirpath)
    print tarball_name
#-------------------------------------------------------------------------------
if __name__ == "__main__":
    main()
#===============================================================================
