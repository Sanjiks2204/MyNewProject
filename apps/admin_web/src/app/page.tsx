import Link from 'next/link';

const stats = [
  { label: 'Active jobs', value: '0', tone: 'mint' },
  { label: 'Pending KYC', value: '0', tone: 'amber' },
  { label: 'Online VIRA', value: '0', tone: 'coral' },
  { label: 'Open disputes', value: '0', tone: 'ink' },
] as const;

const toneClasses: Record<string, string> = {
  mint: 'bg-mint-100 text-mint-700',
  amber: 'bg-amber-100 text-amber-500',
  coral: 'bg-coral-100 text-coral-700',
  ink: 'bg-ink-100 text-ink-700',
};

export default function DashboardPage() {
  return (
    <main className="min-h-screen p-8">
      <header className="flex items-center justify-between mb-10">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-xl bg-gradient-to-br from-coral-500 to-coral-700 flex items-center justify-center">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="white">
              <path d="M13 2L4 14h7l-1 8 9-12h-7l1-8z" />
            </svg>
          </div>
          <div>
            <div className="font-display text-xl font-bold tracking-tight">Mechzo Admin</div>
            <div className="text-xs text-ink-500">Internal operations console</div>
          </div>
        </div>
        <nav className="flex items-center gap-2">
          <Link className="px-4 py-2 rounded-xl bg-white border border-ink-100 text-sm font-semibold" href="/kyc">KYC queue</Link>
          <Link className="px-4 py-2 rounded-xl bg-white border border-ink-100 text-sm font-semibold" href="/jobs">Jobs</Link>
        </nav>
      </header>

      <h1 className="font-display text-3xl font-bold mb-6">Operations</h1>

      <section className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-10">
        {stats.map((s) => (
          <div key={s.label} className="bg-white border border-ink-100 rounded-2xl p-5">
            <div className="text-sm text-ink-500">{s.label}</div>
            <div className="flex items-center gap-3 mt-2">
              <span className="text-3xl font-bold tabular-nums">{s.value}</span>
              <span className={`text-[11px] px-2 py-1 rounded-full font-semibold ${toneClasses[s.tone]}`}>
                Live
              </span>
            </div>
          </div>
        ))}
      </section>

      <section className="bg-white border border-ink-100 rounded-2xl p-8 text-center">
        <div className="text-ink-500 text-sm">
          Connect the API at <code className="bg-ink-50 px-2 py-1 rounded">localhost:3000</code> to see live data.
        </div>
      </section>
    </main>
  );
}
