function ram = ec_ramAvail
ram = java.lang.management.ManagementFactory.getOperatingSystemMXBean().getFreePhysicalMemorySize();
