<script lang="ts" context="module">
  import { Endpoint } from '$lib/types';
  import type { RebootResponse, DeviceCfg } from '$lib/types';
  export async function load({ fetch }) {
    const res: RebootResponse = await fetch(`/api/${Endpoint.REBOOT}`).then((res: Response) =>
      res.json(),
    );
    const rebootResponse: RebootResponse = res.json();
    return {
      props: {
        rebootResponse: rebootResponse
      },
    };
  }
</script>

<script lang="ts">
  import H1 from '$lib/components/ui/H1.svelte';
  import Toggle from '$lib/components/ui/Toggle.svelte';
  import WidgetCard from '$lib/components/ui/WidgetCard.svelte';
  import type { ServerRequest } from '@sveltejs/kit/types/hooks';
  export async function  sendRebootRequest({ fetch }) {
    {
      // const request:ServerRequest = {url: "", method: "POST",headers:{}, body: {}, params: {"endpoint": `${Endpoint.REBOOT}`}, locals: {}} ;
      const data = {action: "Reboot"};

      await fetch(`/api/${Endpoint.SERVICE}`, {method: "POST", body: JSON.stringify(data)}).then((res: Response) =>
              res.json(),
      );

    }
  }
</script>

<H1>Devices</H1>
<!-- <div class="container mx-auto">
  <Table {data} {columns} />
</div> -->
<div class="grid grid-cols-1 gap-4 m-4 md:grid-cols-2 lg:grid-cols-3">
      <WidgetCard>
        <div slot="body">
          <button onsubmit="sendRebootRequest()">Reboot Router</button>
        </div>
      </WidgetCard>
</div>
