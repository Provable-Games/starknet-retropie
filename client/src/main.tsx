import React, { useEffect, useMemo, useState } from "react";
import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import "./index.css";
import { setup, SetupResult } from "./dojo/setup.ts";
import { DojoProvider } from "./dojo/context.tsx";
import { dojoConfig } from "../dojo.config.ts";
import { Loading } from "./ui/screens/Loading";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement,
);

function Main() {
  const [setupResult, setSetupResult] = useState<SetupResult | null>(null);

  const loading = useMemo(() => !setupResult, [setupResult]);

  useEffect(() => {
    async function initialize() {
      const result = await setup(dojoConfig());
      setSetupResult(result);
    }

    initialize();
  }, []);

  return (
    <React.StrictMode>
      {!loading && setupResult ? (
        <DojoProvider value={setupResult}>
          <App />
        </DojoProvider>
      ) : (
        <Loading />
      )}
    </React.StrictMode>
  );
}
root.render(<Main />);
