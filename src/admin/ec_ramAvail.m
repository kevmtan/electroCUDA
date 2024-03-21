function ram = ec_ramAvail(gpu)
%% Get available RAM or VRAM (CPU/GPU)
arguments
    gpu (1,1) logical = false
end

if gpu
    ram = gpuDevice().AvailableMemory;
else
    ram = java.lang.management.ManagementFactory.getOperatingSystemMXBean().getFreePhysicalMemorySize();
end