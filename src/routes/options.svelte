<script lang="ts" context="module">
  import { Endpoint } from '$lib/types';
  import type { DeviceAppStatus, StatusResponse, DeviceCfg } from '$lib/types';
  export async function load({ fetch }) {
    const res: RebootResponse = await fetch(`/api/${Endpoint.REBOOT}`).then((res: Response) =>
      res.json(),
    );
    const devices: DeviceCfg[] = res.device_cfg;
    return {
      props: {
        devices: devices.sort((a, b) =>
          a.HostName.toLowerCase().localeCompare(b.HostName.toLowerCase()),
        ),
      },
    };
  }
</script>

<script lang="ts">
  import H1 from '$lib/components/ui/H1.svelte';
  import Toggle from '$lib/components/ui/Toggle.svelte';
  // import Table from '$lib/components/ui/Table.svelte';
  import WidgetCard from '$lib/components/ui/WidgetCard.svelte';

  export let devices: DeviceCfg[];
  function cleanHostname(hostname: string) {
    return hostname.replace(/.*unknown.*/gi, 'Unknown');
  }
  let columns: string[] = ['Hostname', 'IP', 'MAC', 'Interface', 'Source'];
  let data = devices.map((device) => {
    return {
      Hostname: cleanHostname(device.HostName),
      IP: device.IPAddress,
      MAC: device.MACAddress,
      Interface: device.InterfaceType,
      Source: device.AddressSource,
    };
  });
</script>

<H1>Devices</H1>
<!-- <div class="container mx-auto">
  <Table {data} {columns} />
</div> -->
<div class="grid grid-cols-1 gap-4 m-4 md:grid-cols-2 lg:grid-cols-3">
      <WidgetCard>
        <div slot="body">
          <p>Reboot</p>
          <Toggle active={false}> </Toggle>
        </div>
      </WidgetCard>
</div>
