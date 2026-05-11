import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Mechzo Admin',
  description: 'Mechzo internal operations dashboard.',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body suppressHydrationWarning>{children}</body>
    </html>
  );
}
